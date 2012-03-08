function [ratio] = Er(diag_terms, r)
  if ( min(size(diag_terms)) > 1)
    diag_terms = diag(diag_terms);
  end

  diag_square = diag_terms.*diag_terms;
  ratio = sum(diag_square(1:r))/sum(diag_square);
