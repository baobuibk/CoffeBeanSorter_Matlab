function [ I ] = lm_step3( I )

[row,col]= size(I);
upd      = [];
for r=3:row-2
    for c=3:col-2
        %======================================================
            if (sum(sum(I(r+1:r+2,c+1:c+2))) == 3 )
                [posx,posy]= find(I(r+1:r+2,c+1:c+2));
                pos        = [posx,posy];
                xfi        = r+pos(1,1); 
                yfi        = c+pos(1,2);
                fi = sum(sum(I(xfi-1:xfi+1, yfi-1:yfi+1))) -1;
                
                xse        = r+pos(2,1);
                yse        = c+pos(2,2);
                se = sum(sum(I(xse-1:xse+1, yse-1:yse+1))) -1;
                
                xth        = r+pos(3,1);
                yth        = c+pos(3,2);
                th = sum(sum(I(xth-1:xth+1, yth-1:yth+1))) -1;
                %==============================================
                if (fi==3)&&(se==3)&&(th==3)
                  if(xfi==xse)||(yfi==yse)
                     if (xfi==xth)||(yfi==yth)
                         x_u=xfi;
                         y_u=yfi;
                     else
                         x_u=xse;
                         y_u=yse;
                     end
                  else
                      x_u = xth;
                      y_u = yth;
                  end
                   upd =[upd;[x_u,y_u]];
                end
                %==============================================
            end
    end 
end
%================================================================
size_ad = size(upd,1);
for i=1:size_ad
     I(upd(i,1),upd(i,2)) = 0;
     if I(upd(i,1)+1,upd(i,2)) == 0
         I(upd(i,1)+1,upd(i,2)) = 1;
     else
         I(upd(i,1)-1,upd(i,2)) = 1;
     end
end
end

