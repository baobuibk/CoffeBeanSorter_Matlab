function IMGout = Gaussian_new(msk, IMGBi)

[row,col] = size(IMGBi);
IMGout    = zeros(row,col);

for i= 3:row-2
    for j=3:col-2
        check = sum(sum(msk.* IMGBi(i-2:i+2,j-2:j+2)));
        if check >= 0.5
            IMGout(i,j) = 1;
        else
            IMGout(i,j) = 0;
        end
    end
end
end

