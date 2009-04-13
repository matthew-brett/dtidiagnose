function work_rect = from_fft_slice(o, ftslice)
% Gets (abs, selected, corner cleaned) working rectangle from FFTed slice
% Omit DC components and symmetric part of FT: see
% http://fourier.eng.hmc.edu/e101/lectures/Image_Processing/node6.html
[x y] = size(ftslice);
n_m_pix = ceil(y/2)+1;
work_rect = abs(ftslice(2:end,2:n_m_pix));
% Pull off some edges if required
edge_size = o.edgesize;
if edge_size
  work_rect(:, 1:edge_size) = 0;
  work_rect(1:edge_size,:) = 0;
  work_rect(end-edge_size+1:end, :) = 0;
end
% Pull off low corners
lpc = o.lp_cutoff;
if lpc
  corner = ones(lpc);
  uc = 1-fliplr(triu(corner));
  lc = flipud(uc);
  work_rect(1:lpc,1:lpc) = work_rect(1:lpc,1:lpc) .* uc;
  work_rect(end-(lpc-1):end,1:lpc) = ...
      work_rect(end-(lpc-1):end,1:lpc) .* lc;
end
% convolve
if o.smoothing
  work_rect = convolve(o, work_rect);
end
return
