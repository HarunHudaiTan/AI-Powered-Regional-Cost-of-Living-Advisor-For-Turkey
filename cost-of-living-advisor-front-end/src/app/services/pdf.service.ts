import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { jsPDF } from 'jspdf';
import html2canvas from 'html2canvas';
import { marked } from 'marked';
import { AuthService } from './auth.service';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class PdfService {
  private apiUrl = environment.apiUrl;

  constructor(
    private http: HttpClient,
    private authService: AuthService
  ) {
    // Configure marked for better rendering
    marked.setOptions({
      breaks: true,
      gfm: true
    });
  }

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

  // Convert markdown to HTML with enhanced styling
  async convertMarkdownToHtml(markdownContent: string): Promise<string> {
    const htmlContent = await marked(markdownContent);
    
    // Wrap in a styled container
    return `
      <div class="report-container">
        <style>
          .report-container {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 40px;
            line-height: 1.6;
            color: #333;
            background: white;
          }
          
          .report-container h1 {
            color: #1e3a8a;
            font-size: 28px;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #3b82f6;
            text-align: center;
          }
          
          .report-container h2 {
            color: #1e40af;
            font-size: 22px;
            margin-top: 35px;
            margin-bottom: 20px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e5e7eb;
          }
          
          .report-container h3 {
            color: #374151;
            font-size: 18px;
            margin-top: 25px;
            margin-bottom: 15px;
            font-weight: 600;
          }
          
          .report-container p {
            margin-bottom: 15px;
            text-align: justify;
            text-justify: inter-word;
          }
          
          .report-container strong {
            color: #1f2937;
            font-weight: 700;
          }
          
          .report-container ul, .report-container ol {
            margin: 20px 0;
            padding-left: 30px;
          }
          
          .report-container li {
            margin-bottom: 8px;
            line-height: 1.5;
          }
          
          .report-container table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
          }
          
          .report-container th {
            background-color: #3b82f6;
            color: white;
            padding: 15px 12px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
          }
          
          .report-container td {
            padding: 12px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 14px;
          }
          
          .report-container tr:nth-child(even) {
            background-color: #f8fafc;
          }
          
          .report-container tr:hover {
            background-color: #f1f5f9;
          }
          
          .report-container blockquote {
            border-left: 4px solid #3b82f6;
            margin: 20px 0;
            padding: 15px 20px;
            background-color: #f8fafc;
            font-style: italic;
          }
          
          .report-container code {
            background-color: #f3f4f6;
            padding: 2px 6px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 13px;
          }
          
          .report-container .highlight-box {
            background-color: #fef3c7;
            border: 1px solid #f59e0b;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
          }
          
          .report-container .success-box {
            background-color: #dcfce7;
            border: 1px solid #16a34a;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
          }
          
          .report-container .warning-box {
            background-color: #fef2f2;
            border: 1px solid #dc2626;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
          }
          
          @media print {
            .report-container {
              padding: 20px;
            }
            .report-container h1 {
              font-size: 24px;
            }
            .report-container h2 {
              font-size: 20px;
            }
          }
        </style>
        ${htmlContent}
      </div>
    `;
  }

  // Enhanced PDF generation with better handling for reports
  async generatePdfFromHtml(htmlContent: string, filename: string = 'analysis-report'): Promise<Blob> {
    // Create a temporary container for the HTML content
    const container = document.createElement('div');
    container.innerHTML = htmlContent;
    container.style.position = 'absolute';
    container.style.left = '-9999px';
    container.style.top = '0';
    container.style.width = '794px'; // A4 width in pixels at 96 DPI
    container.style.background = 'white';

    // Add to document temporarily
    document.body.appendChild(container);

    try {
      // Wait for fonts to load
      await document.fonts.ready;

      // Convert to canvas using html2canvas with optimized settings
      const canvas = await html2canvas(container, {
        scale: 1.5, // Good balance between quality and performance
        useCORS: true,
        allowTaint: true,
        backgroundColor: '#ffffff',
        width: 794,
        windowWidth: 794,
        scrollX: 0,
        scrollY: 0
      });

      // Create PDF in A4 format
      const pdf = new jsPDF('p', 'mm', 'a4');
      const pdfWidth = pdf.internal.pageSize.getWidth();
      const pdfHeight = pdf.internal.pageSize.getHeight();
      
      const canvasWidth = canvas.width;
      const canvasHeight = canvas.height;
      
      // Convert pixels to mm (assuming 96 DPI)
      const mmPerPx = 25.4 / 96;
      const contentWidth = canvasWidth * mmPerPx / 1.5; // Adjust for scale
      const contentHeight = canvasHeight * mmPerPx / 1.5;
      
      // Calculate scaling to fit page width
      const scale = Math.min(pdfWidth / contentWidth, 1);
      const scaledWidth = contentWidth * scale;
      const scaledHeight = contentHeight * scale;
      
      // Center horizontally
      const xOffset = (pdfWidth - scaledWidth) / 2;
      
      const imgData = canvas.toDataURL('image/jpeg', 0.95);
      
      // Add content page by page
      let yPosition = 10; // Start with some margin
      let remainingHeight = scaledHeight;
      const pageHeight = pdfHeight - 20; // Leave margins
      
      // First page
      if (remainingHeight <= pageHeight) {
        // Content fits on one page
        pdf.addImage(imgData, 'JPEG', xOffset, yPosition, scaledWidth, scaledHeight);
      } else {
        // Content needs multiple pages
        let sourceY = 0;
        let currentPage = 1;
        
        while (remainingHeight > 0) {
          if (currentPage > 1) {
            pdf.addPage();
          }
          
          const currentPageHeight = Math.min(pageHeight, remainingHeight);
          const sourceHeight = (currentPageHeight / scaledHeight) * canvasHeight;
          
          // Create a temporary canvas for this page
          const pageCanvas = document.createElement('canvas');
          pageCanvas.width = canvasWidth;
          pageCanvas.height = sourceHeight;
          const pageCtx = pageCanvas.getContext('2d');
          
          if (pageCtx) {
            pageCtx.drawImage(canvas, 0, sourceY, canvasWidth, sourceHeight, 0, 0, canvasWidth, sourceHeight);
            const pageImgData = pageCanvas.toDataURL('image/jpeg', 0.95);
            pdf.addImage(pageImgData, 'JPEG', xOffset, yPosition, scaledWidth, currentPageHeight);
          }
          
          sourceY += sourceHeight;
          remainingHeight -= pageHeight;
          currentPage++;
        }
      }

      // Add metadata
      pdf.setProperties({
        title: 'Cost of Living Analysis Report',
        subject: 'Location Comparison Analysis',
        author: 'Cost of Living Analyzer',
        creator: 'Angular PDF Service'
      });

      return pdf.output('blob');
    } finally {
      // Clean up
      document.body.removeChild(container);
    }
  }

  // Enhanced download method
  async downloadPdf(markdownContent: string, filename: string = 'cost-of-living-analysis'): Promise<void> {
    try {
      const htmlContent = await this.convertMarkdownToHtml(markdownContent);
      const pdfBlob = await this.generatePdfFromHtml(htmlContent, filename);
      
      // Create download link with better browser compatibility
      const url = window.URL.createObjectURL(pdfBlob);
      const link = document.createElement('a');
      link.href = url;
      link.download = `${filename}-${new Date().toISOString().split('T')[0]}.pdf`;
      link.style.display = 'none';
      
      // Trigger download with better compatibility
      document.body.appendChild(link);
      
      // Force click for better browser support
      if (link.click) {
        link.click();
      } else {
        // Fallback for older browsers
        const event = new MouseEvent('click', {
          view: window,
          bubbles: true,
          cancelable: true
        });
        link.dispatchEvent(event);
      }
      
      // Clean up immediately after download
      document.body.removeChild(link);
      
      // Clean up blob URL after a delay to ensure download completes
      setTimeout(() => {
        window.URL.revokeObjectURL(url);
      }, 1000);
    } catch (error) {
      console.error('Error generating PDF:', error);
      throw error;
    }
  }

  // Create blob URL for viewing
  async createPdfBlobUrl(markdownContent: string): Promise<string> {
    const htmlContent = await this.convertMarkdownToHtml(markdownContent);
    const pdfBlob = await this.generatePdfFromHtml(htmlContent);
    return window.URL.createObjectURL(pdfBlob);
  }

  // Preview HTML content (useful for debugging)
  async previewHtml(markdownContent: string): Promise<void> {
    const htmlContent = await this.convertMarkdownToHtml(markdownContent);
    const newWindow = window.open('', '_blank');
    if (newWindow) {
      newWindow.document.write(htmlContent);
      newWindow.document.close();
    }
  }

  // Utility method to estimate PDF page count
  async estimatePageCount(markdownContent: string): Promise<number> {
    const htmlContent = await this.convertMarkdownToHtml(markdownContent);
    const container = document.createElement('div');
    container.innerHTML = htmlContent;
    container.style.position = 'absolute';
    container.style.left = '-9999px';
    container.style.width = '794px';
    
    document.body.appendChild(container);
    
    try {
      const height = container.offsetHeight;
      const a4HeightPx = 1123; // A4 height in pixels at 96 DPI
      return Math.ceil(height / a4HeightPx);
    } finally {
      document.body.removeChild(container);
    }
  }

  private getToken(): string | null {
    if (typeof window !== 'undefined' && window.localStorage) {
      return localStorage.getItem('access_token');
    }
    return null;
  }
}