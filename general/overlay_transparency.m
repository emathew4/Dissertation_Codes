function overlay_transparency(vol,overlay)

figure;h=montage(mat2gray(vol));
h.AlphaData=.7;
hold on;
d=montage(overlay);
d.AlphaData=.1;