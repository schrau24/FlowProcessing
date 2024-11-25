function currSeg = mask_erosion_Bobby(currSeg,diagonal_neighbour_flag)
% 2024, written by Bobby Runderkamp to be used in conjunction with FlowProcessing
% pipeline by Eric Schrauben.
% diagonal_neighbour_flag == 1 means including diagonal neighbours.
% diagonal_neighbour_flag == 0 means not including diagonal neighbours.
% Using diagonal_neighbour_flag == 0 is advised.
tmp_currSeg = zeros(size(currSeg));
for ii = 1:size(currSeg,1)
    for jj = 1:size(currSeg,2)
        for kk = 1:size(currSeg,3)
            if currSeg(ii,jj,kk) ~= 0
                if diagonal_neighbour_flag == 1
                    neighbourlist = [ii+1,jj+1,kk+1;
                                    ii+1,jj+1,kk;
                                    ii+1,jj+1,kk-1;
                                    ii+1,jj,kk+1;
                                    ii+1,jj,kk;
                                    ii+1,jj,kk-1;
                                    ii+1,jj-1,kk+1;
                                    ii+1,jj-1,kk;
                                    ii+1,jj-1,kk-1;
                                    ii,jj+1,kk+1;
                                    ii,jj+1,kk;
                                    ii,jj+1,kk-1;
                                    ii,jj,kk+1;
                                    ii,jj,kk;
                                    ii,jj,kk-1;
                                    ii,jj-1,kk+1;
                                    ii,jj-1,kk;
                                    ii,jj-1,kk-1;
                                    ii-1,jj+1,kk+1;
                                    ii-1,jj+1,kk;
                                    ii-1,jj+1,kk-1;
                                    ii-1,jj,kk+1;
                                    ii-1,jj,kk;
                                    ii-1,jj,kk-1;
                                    ii-1,jj-1,kk+1;
                                    ii-1,jj-1,kk;
                                    ii-1,jj-1,kk-1];
                elseif diagonal_neighbour_flag == 0
                    neighbourlist = [ii+1,jj,kk;
                                    ii,jj+1,kk;
                                    ii,jj,kk+1;
                                    ii,jj,kk;
                                    ii,jj,kk-1;
                                    ii,jj-1,kk;
                                    ii-1,jj,kk];
                end
                zeros_count = 0;
                for nn = 1:size(neighbourlist,1)
                    try 
                        if currSeg(neighbourlist(nn,1),neighbourlist(nn,2),neighbourlist(nn,3)) == 0
                            zeros_count = zeros_count + 1;
                        end
                    catch
                    end
                end
                if zeros_count == 0
                    tmp_currSeg(ii,jj,kk) = 1;
                end
            end
        end
    end
end
currSeg = tmp_currSeg;
% figure;subplot(131);imshow(squeeze(abs(currSeg(:,:,round(end/2))))~=0,[]);colorbar;subplot(132);imshow(squeeze(abs(currSeg(:,round(end/2),:)))~=0,[]);colorbar;subplot(133);imshow(squeeze(abs(currSeg(round(end/2),:,:)))~=0,[]);colorbar;
% figure;subplot(131);imshow(squeeze(abs(tmp_currSeg(:,:,round(end/2))))~=0,[]);colorbar;subplot(132);imshow(squeeze(abs(tmp_currSeg(:,round(end/2),:)))~=0,[]);colorbar;subplot(133);imshow(squeeze(abs(tmp_currSeg(round(end/2),:,:)))~=0,[]);colorbar;
% 
% figure;subplot(131);imshow(squeeze(abs(currSeg(:,:,round(end/2))))~=0,[]);colorbar;subplot(132);imshow(squeeze(abs(currSeg(:,:,round(end/2)+1)))~=0,[]);colorbar;subplot(133);imshow(squeeze(abs(currSeg(:,:,round(end/2)-1)))~=0,[]);colorbar;
% figure;subplot(131);imshow(squeeze(abs(tmp_currSeg(:,:,round(end/2))))~=0,[]);colorbar;subplot(132);imshow(squeeze(abs(tmp_currSeg(:,:,round(end/2)+1)))~=0,[]);colorbar;subplot(133);imshow(squeeze(abs(tmp_currSeg(:,:,round(end/2)-1)))~=0,[]);colorbar;

