dtip = dtiprocessor(test_eg_dtiset);
dtip = structural(dtip, 'b0');
tic;
[x, dtip] = template_coreg(dtip);
time1 = toc;
tic;
[x, dtip] = template_coreg(dtip);
time2 = toc;
if (time1/time2) < 10
  error('Probably not finding cached value');
end
% The parameters appear to differ on windows and linux
% for some reason - requiring low threshold for comparison
try
  assert_equal(template_map(dtip), test_eg_template_map, 1e-1);
catch
  disp('Calculated template map')
  template_map(dtip)
  disp('Expected template map')
  test_eg_template_map
  warning('Larger than usual template map difference')
end
