function I   =  lm_step2_cd2(I)
[hang,cot] = size(I);
M = uint8(ones(hang,cot));
I=uint8(I);
xnei=zeros(1,8);
ynei=zeros(1,8);
for h=2:(hang-1)
    for c=2:(cot-1)
        checkI=0;
        dem1=0;
        dem2=0;
        if(I(h,c)==0) 
            continue;
        else
            %==============================================================%
            for i=-1:1:1
                for j=-1:1:1
                    if (I(h+i,c+j)==1)&&((i~=0)||(j~=0))
                        checkI=checkI+1;
                        xnei(1,checkI)=h+i;
                        ynei(1,checkI)=c+j;
                    end
                end
            end
            %============================checknei
            if checkI==3
                for k=1:3
                    checknei=0;
                %==================%
                     for i=-1:1:1
                         for j=-1:1:1
                              if (I(xnei(1,k)+i,ynei(1,k)+j)==1)&&((i~=0)||(j~=0))
                                   checknei=checknei+1;
                              end
                         end
                     end
                    %==================%
                    if checknei==3
                        dem1=dem1+1;
                    elseif checknei==4 
                        dem2=dem2+1;
                    end
                %==================%
                end
                if (dem1==2)&&(dem2==1) 
                    M(h,c)=0;
                end
            end
            %============================checknei
             %==============================================================%
        end
    end
end
I=I.*M;

end

