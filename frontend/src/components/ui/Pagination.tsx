"use client";

import  Button  from "./Button";

export interface PaginationProps {
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  className?: string;
  showPageNumbers?: boolean;
  maxVisiblePages?: number;
}

export function Pagination({
  currentPage,
  totalPages,
  onPageChange,
  className = "",
  showPageNumbers = true,
  maxVisiblePages = 5,
}: PaginationProps) {
  if (totalPages <= 1) return null;

  // Generate page numbers to show
  const getPageNumbers = () => {
    if (totalPages <= maxVisiblePages) {
      return Array.from({ length: totalPages }, (_, i) => i + 1);
    }

    const startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
    const endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

    const pages = [];
    for (let i = startPage; i <= endPage; i++) {
      pages.push(i);
    }
    return pages;
  };

  const pageNumbers = getPageNumbers();

  return (
    <div className={`flex flex-col sm:flex-row items-center justify-between gap-3 sm:gap-4 ${className}`}>
      {/* Page Info */}
      <div className="text-xs sm:text-sm text-gray-600 order-1 sm:order-none">
        Page {currentPage} of {totalPages}
      </div>

      {/* Controls */}
      <div className="flex items-center gap-1.5 sm:gap-2 order-2 sm:order-none">
        {/* Previous Button */}
        <Button
          onClick={() => onPageChange(currentPage - 1)}
          disabled={currentPage === 1}
          variant="secondary"
          className="min-w-[80px] sm:min-w-[100px] px-3 sm:px-4 py-1.5 sm:py-2 text-sm"
        >
          Previous
        </Button>

        {/* Page Numbers */}
        {showPageNumbers && (
          <div className="flex items-center gap-0.5 sm:gap-1 mx-1 sm:mx-2">
            {pageNumbers.map((page) => (
              <button
                key={page}
                onClick={() => onPageChange(page)}
                className={`w-8 h-8 sm:w-10 sm:h-10 rounded-lg text-xs sm:text-sm font-medium transition-all ${
                  currentPage === page
                    ? "bg-blue-600 text-white shadow-md"
                    : "bg-gray-100 text-gray-700 hover:bg-gray-200"
                }`}
              >
                {page}
              </button>
            ))}
            
            {/* Ellipsis for many pages */}
            {totalPages > maxVisiblePages && currentPage < totalPages - Math.floor(maxVisiblePages / 2) && (
              <span className="px-1 sm:px-2 text-gray-400 text-xs sm:text-sm">...</span>
            )}
          </div>
        )}

        {/* Next Button */}
        <Button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={currentPage === totalPages}
          variant="secondary"
          className="min-w-[80px] sm:min-w-[100px] px-3 sm:px-4 py-1.5 sm:py-2 text-sm"
        >
          Next
        </Button>
      </div>

      {/* Results Info */}
      <div className="text-xs sm:text-sm text-gray-500 hidden lg:block order-3 sm:order-none">
        {totalPages} page{totalPages !== 1 ? 's' : ''} total
      </div>
    </div>
  );
}