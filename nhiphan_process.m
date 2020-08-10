function img = nhiphan_process(img,blk)

[row,col]  = size(img);
row = floor(row/blk)*blk;
col = floor(col/blk)*blk;
%tem_img      = zeros(blk,blk);
for r=5:blk:(row-(blk-5)-1)
    for c=5:blk:(col-(blk-5)-1)
        %------------------------------------------------------------------%
        tem_img = img(r:r+blk-1,c:c+blk-1);
        %------------------------------------------------------------------%
        nguongK = np_otsus_process(tem_img);
        %------------------------------------------------------------------%

        img(r:r+blk-1,c:c+blk-1) = (tem_img > nguongK);
        %------------------------------------------------------------------%
    end
end

img = img(5:row-(blk-5)-1,5:col-(blk-5)-1);
end

