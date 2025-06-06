import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { jsPDF } from 'jspdf';
import html2canvas from 'html2canvas';
import { marked } from 'marked';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PdfService {
  private apiUrl = 'http://127.0.0.1:5000/api';

  constructor(
    private http: HttpClient,
    private authService: AuthService
  ) {}

  // Fetch markdown content from the API
  generateRootLlmResponse(): Observable<string> {
    const token = this.getToken();
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    });

    return this.http.get<string>(`${this.apiUrl}/generate_root_llm_response`, { 
      headers,
      responseType: 'text' as 'json'
    });
  }

  // Convert markdown to HTML
  async convertMarkdownToHtml(markdownContent: string): Promise<string> {
    return await marked(markdownContent);
  }

  // Generate PDF from HTML content
  async generatePdfFromHtml(htmlContent: string, filename: string = 'analysis-report'): Promise<Blob> {
    // Create a temporary container for the HTML content
    const container = document.createElement('div');
    container.innerHTML = htmlContent;
    container.style.width = '210mm'; // A4 width
    container.style.padding = '20mm';
    container.style.fontFamily = 'Arial, sans-serif';
    container.style.fontSize = '12px';
    container.style.lineHeight = '1.6';
    container.style.color = '#333';
    container.style.background = 'white';
    container.style.position = 'absolute';
    container.style.left = '-9999px';
    container.style.top = '0';

    // Style headers and other elements
    const headers = container.querySelectorAll('h1, h2, h3, h4, h5, h6');
    headers.forEach((header, index) => {
      (header as HTMLElement).style.color = '#2c3e50';
      (header as HTMLElement).style.marginTop = index === 0 ? '0' : '20px';
      (header as HTMLElement).style.marginBottom = '10px';
    });

    const paragraphs = container.querySelectorAll('p');
    paragraphs.forEach(p => {
      (p as HTMLElement).style.marginBottom = '10px';
      (p as HTMLElement).style.textAlign = 'justify';
    });

    const lists = container.querySelectorAll('ul, ol');
    lists.forEach(list => {
      (list as HTMLElement).style.marginBottom = '10px';
      (list as HTMLElement).style.paddingLeft = '20px';
    });

    // Add to document temporarily
    document.body.appendChild(container);

    try {
      // Convert to canvas using html2canvas
      const canvas = await html2canvas(container, {
        scale: 2,
        useCORS: true,
        allowTaint: true,
        backgroundColor: '#ffffff'
      });

      // Create PDF
      const pdf = new jsPDF('p', 'mm', 'a4');
      const pdfWidth = pdf.internal.pageSize.getWidth();
      const pdfHeight = pdf.internal.pageSize.getHeight();
      
      const canvasWidth = canvas.width;
      const canvasHeight = canvas.height;
      
      // Calculate scaling to fit the page
      const ratio = Math.min(pdfWidth / (canvasWidth * 0.264583), pdfHeight / (canvasHeight * 0.264583));
      const scaledWidth = canvasWidth * 0.264583 * ratio;
      const scaledHeight = canvasHeight * 0.264583 * ratio;
      
      // Center the content
      const xOffset = (pdfWidth - scaledWidth) / 2;
      const yOffset = (pdfHeight - scaledHeight) / 2;

      // Add image to PDF
      const imgData = canvas.toDataURL('image/png');
      pdf.addImage(imgData, 'PNG', xOffset, yOffset, scaledWidth, scaledHeight);

      // If content is too tall, add more pages
      if (scaledHeight > pdfHeight) {
        let remainingHeight = scaledHeight - pdfHeight;
        let currentY = -pdfHeight + yOffset;

        while (remainingHeight > 0) {
          pdf.addPage();
          currentY -= pdfHeight;
          pdf.addImage(imgData, 'PNG', xOffset, currentY, scaledWidth, scaledHeight);
          remainingHeight -= pdfHeight;
        }
      }

      // Return PDF as blob
      return pdf.output('blob');
    } finally {
      // Clean up
      document.body.removeChild(container);
    }
  }

  // Download PDF
  async downloadPdf(markdownContent: string, filename: string = 'cost-of-living-analysis'): Promise<void> {
    const htmlContent = await this.convertMarkdownToHtml(markdownContent);
    const pdfBlob = await this.generatePdfFromHtml(htmlContent, filename);
    
    // Create download link
    const url = window.URL.createObjectURL(pdfBlob);
    const link = document.createElement('a');
    link.href = url;
    link.download = `${filename}.pdf`;
    link.click();
    
    // Clean up
    window.URL.revokeObjectURL(url);
  }

  // Create blob URL for viewing
  async createPdfBlobUrl(markdownContent: string): Promise<string> {
    const htmlContent = await this.convertMarkdownToHtml(markdownContent);
    const pdfBlob = await this.generatePdfFromHtml(htmlContent);
    return window.URL.createObjectURL(pdfBlob);
  }

  private getToken(): string | null {
    if (typeof window !== 'undefined' && window.localStorage) {
      return localStorage.getItem('access_token');
    }
    return null;
  }
} 