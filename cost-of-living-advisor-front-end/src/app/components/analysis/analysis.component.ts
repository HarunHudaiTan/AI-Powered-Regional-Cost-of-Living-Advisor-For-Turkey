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
  isDownloading: boolean = false;

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
    this.markdownContent = '';
    this.htmlContent = '';

    try {
      console.log('About to call pdfService.generateRootLlmResponse()');
      this.pdfService.generateRootLlmResponse().subscribe({
        next: async (response) => {
          console.log('API response received:', response);
          
          // Ensure we have valid content
          if (!response || typeof response !== 'string' || response.trim().length === 0) {
            throw new Error('Invalid or empty response from server');
          }
          
          this.markdownContent = response.trim();
          
          try {
            // Convert to HTML for display
            const htmlString = await this.pdfService.convertMarkdownToHtml(this.markdownContent);
            this.htmlContent = this.sanitizer.bypassSecurityTrustHtml(htmlString);
          } catch (htmlError) {
            console.error('Error converting markdown to HTML:', htmlError);
            // Fallback: display raw markdown
            this.htmlContent = this.sanitizer.bypassSecurityTrustHtml(
              `<pre style="white-space: pre-wrap; font-family: inherit;">${this.markdownContent}</pre>`
            );
          }
          
          this.isLoading = false;
        },
        error: (error) => {
          console.error('Error fetching analysis:', error);
          this.error = this.getErrorMessage(error);
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
    if (!this.markdownContent || this.markdownContent.trim().length === 0) {
      this.error = 'No content available to download.';
      return;
    }

    try {
      this.isDownloading = true;
      this.error = '';
      
      console.log('Starting PDF download...');
      
      // Use the updated PDF service download method
      await this.pdfService.downloadPdf(this.markdownContent, 'cost-of-living-analysis-report');
      
      console.log('PDF download completed successfully');
      this.isDownloading = false;
      
    } catch (error) {
      console.error('Error downloading PDF:', error);
      this.error = 'Failed to download PDF. Please try again.';
      this.isDownloading = false;
      
      // Fallback: try to open in new window
      try {
        const htmlContent = await this.pdfService.convertMarkdownToHtml(this.markdownContent);
        const newWindow = window.open('', '_blank');
        if (newWindow) {
          newWindow.document.write(`
            <html>
              <head>
                <title>Cost of Living Analysis Report</title>
                <style>
                  body { font-family: Arial, sans-serif; padding: 20px; max-width: 800px; margin: 0 auto; }
                  @media print { body { padding: 0; } }
                </style>
              </head>
              <body>
                ${htmlContent}
                <script>
                  window.onload = function() {
                    setTimeout(function() { window.print(); }, 500);
                  };
                </script>
              </body>
            </html>
          `);
          newWindow.document.close();
        }
      } catch (fallbackError) {
        console.error('Fallback method also failed:', fallbackError);
      }
    }
  }

  async previewPdf(): Promise<void> {
    if (!this.markdownContent || this.markdownContent.trim().length === 0) {
      this.error = 'No content available to preview.';
      return;
    }

    try {
      this.isLoading = true;
      this.error = '';
      
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

  // Helper method to extract meaningful error messages
  private getErrorMessage(error: any): string {
    if (error?.error?.message) {
      return error.error.message;
    }
    if (error?.message) {
      return error.message;
    }
    if (error?.status === 401) {
      return 'Authentication failed. Please log in again.';
    }
    if (error?.status === 403) {
      return 'Access denied. You do not have permission to view this content.';
    }
    if (error?.status === 404) {
      return 'Analysis endpoint not found. Please contact support.';
    }
    if (error?.status === 500) {
      return 'Server error. Please try again later.';
    }
    if (error?.status === 0) {
      return 'Connection failed. Please check your internet connection.';
    }
    return 'Failed to load analysis. Please try again.';
  }

  // Getter for template to check if we're in any loading state
  get isAnyLoading(): boolean {
    return this.isLoading || this.isDownloading;
  }
}