import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { DomSanitizer, SafeHtml, SafeResourceUrl } from '@angular/platform-browser';
import { PdfService } from '../../services/pdf.service';

@Component({
  selector: 'app-analysis',
  templateUrl: './analysis.component.html',
  styleUrls: ['./analysis.component.css']
})
export class AnalysisComponent implements OnInit, OnDestroy {
  markdownContent: string = '';
  htmlContent: SafeHtml = '';
  isLoading: boolean = false;
  error: string = '';
  pdfBlobUrl: SafeResourceUrl = '';
  pdfBlobUrlString: string = '';
  showPdfPreview: boolean = false;

  constructor(
    private pdfService: PdfService,
    private router: Router,
    private sanitizer: DomSanitizer
  ) {}

  ngOnInit(): void {
    console.log('AnalysisComponent ngOnInit called');
    this.loadAnalysis();
  }

  ngOnDestroy(): void {
    // Clean up blob URL when component is destroyed
    if (this.pdfBlobUrlString) {
      window.URL.revokeObjectURL(this.pdfBlobUrlString);
    }
  }

  async loadAnalysis(): Promise<void> {
    console.log('loadAnalysis called');
    this.isLoading = true;
    this.error = '';

    try {
      // Fetch markdown content from API
      console.log('About to call pdfService.generateRootLlmResponse()');
      this.pdfService.generateRootLlmResponse().subscribe({
        next: async (response) => {
          console.log('API response received:', response);
          this.markdownContent = response;
          // Convert to HTML for display
          const htmlString = await this.pdfService.convertMarkdownToHtml(this.markdownContent);
          this.htmlContent = this.sanitizer.bypassSecurityTrustHtml(htmlString);
          this.isLoading = false;
        },
        error: (error) => {
          console.error('Error fetching analysis:', error);
          this.error = 'Failed to load analysis. Please try again.';
          this.isLoading = false;
        }
      });
    } catch (error) {
      console.error('Error loading analysis:', error);
      this.error = 'Failed to load analysis. Please try again.';
      this.isLoading = false;
    }
  }

  async downloadPdf(): Promise<void> {
    if (!this.markdownContent) {
      this.error = 'No content available to download.';
      return;
    }

    try {
      this.isLoading = true;
      await this.pdfService.downloadPdf(this.markdownContent, 'cost-of-living-analysis-report');
      this.isLoading = false;
    } catch (error) {
      console.error('Error downloading PDF:', error);
      this.error = 'Failed to download PDF. Please try again.';
      this.isLoading = false;
    }
  }

  async previewPdf(): Promise<void> {
    if (!this.markdownContent) {
      this.error = 'No content available to preview.';
      return;
    }

    try {
      this.isLoading = true;
      
      // Clean up previous blob URL
      if (this.pdfBlobUrlString) {
        window.URL.revokeObjectURL(this.pdfBlobUrlString);
      }
      
      this.pdfBlobUrlString = await this.pdfService.createPdfBlobUrl(this.markdownContent);
      this.pdfBlobUrl = this.sanitizer.bypassSecurityTrustResourceUrl(this.pdfBlobUrlString);
      this.showPdfPreview = true;
      this.isLoading = false;
    } catch (error) {
      console.error('Error creating PDF preview:', error);
      this.error = 'Failed to create PDF preview. Please try again.';
      this.isLoading = false;
    }
  }

  closePdfPreview(): void {
    this.showPdfPreview = false;
    if (this.pdfBlobUrlString) {
      window.URL.revokeObjectURL(this.pdfBlobUrlString);
      this.pdfBlobUrlString = '';
      this.pdfBlobUrl = '';
    }
  }

  goBack(): void {
    this.router.navigate(['/dashboard']);
  }

  refreshAnalysis(): void {
    this.loadAnalysis();
  }
}
