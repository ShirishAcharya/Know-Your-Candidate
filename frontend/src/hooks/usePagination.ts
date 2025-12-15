import { useState, useMemo, useCallback } from "react";

export interface UsePaginationProps {
  totalItems: number;
  pageSize: number;
  initialPage?: number;
}

export interface UsePaginationReturn {
  currentPage: number;
  totalPages: number;
  pageSize: number;
  offset: number;
  setPage: (page: number) => void;
  nextPage: () => void;
  previousPage: () => void;
  canNextPage: boolean;
  canPreviousPage: boolean;
}

export function usePagination({
  totalItems,
  pageSize,
  initialPage = 1,
}: UsePaginationProps): UsePaginationReturn {
  const [currentPage, setCurrentPage] = useState(initialPage);

  const totalPages = Math.max(1, Math.ceil(totalItems / pageSize));
  const offset = (currentPage - 1) * pageSize;

  const canNextPage = currentPage < totalPages;
  const canPreviousPage = currentPage > 1;

  // ✅ Memoize setPage
  const setPage = useCallback((page: number) => {
    const validPage = Math.max(1, Math.min(page, totalPages));
    setCurrentPage(validPage);
  }, [totalPages]);

  // ✅ Memoize nextPage
  const nextPage = useCallback(() => {
    if (canNextPage) setCurrentPage(prev => prev + 1);
  }, [canNextPage]);

  // ✅ Memoize previousPage
  const previousPage = useCallback(() => {
    if (canPreviousPage) setCurrentPage(prev => prev - 1);
  }, [canPreviousPage]);

  return {
    currentPage,
    totalPages,
    pageSize,
    offset,
    setPage,
    nextPage,
    previousPage,
    canNextPage,
    canPreviousPage,
  };
}