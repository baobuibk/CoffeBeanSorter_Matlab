function out = Gaussian_filter(sizes, sigma)


out = zeros(sizes,sizes);
sizes = floor(sizes/2);
for y=-sizes:1:sizes
    for x=-sizes:1:sizes
        out(x+sizes+1,sizes+y+1) = exp(-(x.^2+y.^2)/(2*sigma*sigma))/(2*pi*(sigma*sigma));
    end
end
out = out./sum(sum(out(:,:)));
end


