function o = from_slice(o, img_slice)
% Gets (abs, selected, corner cleaned) working rectangle from slice
fft_slice = fft2(img_slice);
o = from_fft_slice(o, fft_slice);
