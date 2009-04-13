function [hitrate, fprate] = rocvals(testlist, truelist)
% Calculate true pos, false negative rates
% FORMAT [hitrate, fprate] = rocvals(testlist, truelist)
all_count = testlist.n_vols * testlist.n_slices;
[hits, falseposes, misses] = inouts(testlist, truelist);
tpcount = slicecount(truelist);
tncount = max_slicecount(truelist)-tpcount;
hitrate = slicecount(hits) / tpcount;
fprate = slicecount(falseposes) / tncount;
return
