function [ out_img ] = lm_step2( in_img )


%%========================================= Efficient Parallel algorithm
%out_img = lm_step2_cd2_eff(in_img);
%out_img = lm_step2_cd1(out_img);

%========================================= Proposal our algorithm
out_img = lm_step2_cd1(in_img);
out_img = lm_step2_cd2(out_img);


end

