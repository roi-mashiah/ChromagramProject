function [] = plot_images(im, compression_method, title_str, ylabels, parameter)
switch compression_method
    case "log"
        cmp_im = log10(1+ parameter*im);
    case "nroot"
        cmp_im = im.^(1/parameter);
    case "linear"
        cmp_im = im; % linear
end
figure
imagesc(cmp_im); hold on
s = size(cmp_im);
xrange = [1, size(cmp_im,2)];
yrange = [1, size(cmp_im,1)];
dx = diff(xrange)/(s(2)-1);
dy = diff(yrange)/(s(1)-1);
xg = linspace(xrange(1)-dx/2,xrange(2)+dx/2,s(2)+1);
yg = linspace(yrange(1)-dy/2,yrange(2)+dy/2,s(1)+1);
hm = mesh(xg,yg,zeros(s+1));
hm.FaceColor = 'none';
hm.EdgeColor = 'k';
yticks(1:size(cmp_im,1))
ytickangle(15)
yticklabels(ylabels)
set(gca,'YDir','normal')
title(strcat(title_str, " Compression - ", compression_method, " Parameter - ", num2str(parameter)))
colorbar
end

