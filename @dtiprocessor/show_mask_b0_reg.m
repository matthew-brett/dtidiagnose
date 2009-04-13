function show_mask_b0_reg(o)
% Show registration of mask and B0 image
bzvol = bzero_image(o);
spm_check_registration([bzvol, o.mask]);
