function [IND_F,IND_V]=patchIND(F,V)
%[IND_F,IND_V]=patchIND(F,V)
%finds faces for points
%finds points for faces
%
% Author: kevin moerman
% 19 apr 2011

JF=(1:1:size(F,1))'*ones(1,3); JF=JF(:);
IF=F(:);
VF_IND_sp=sparse(IF,JF,JF,size(V,1),size(F,1));
FV_IND_sp=sparse(IF,JF,IF,size(V,1),size(F,1));

V_count=full(sum(FV_IND_sp>0,2));
V_count_max=max(V_count(:));
IND=(ones(size(V,1),1)*(1:1:V_count_max))';
L=(IND<=(V_count*ones(1,V_count_max))');

VF_IND_sp=VF_IND_sp';
IND_F=zeros(V_count_max,size(V,1));
[I,~,~] = find(VF_IND_sp);
IND_F(L)=I;
IND_F=IND_F';
IND_V=[];
for i=1:1:size(F,2)
    A=IND_F;
    A(A~=0)=F(A(A~=0),i);
    IND_V(:,end+1:end+size(A,2))=A;
end

IND_V=sparse(IND_V);
[I,~,v] = find(IND_V);
Iv=[I v];
[Iv_uni, ~, ~] = unique(Iv,'rows');
I=Iv_uni(:,1); v=Iv_uni(:,2);
IND_V=sparse(I,v,v,size(IND_V,1),size(IND_V,1));

IND_V=sort(IND_V,2);
[~,J,~] = find(IND_V);
IND_V=full(IND_V(:,min(J):end));
IND_L=(1:1:size(IND_V,1))'*ones(1,size(IND_V,2));
IND_V(IND_V==IND_L)=0;
IND_V=sort(IND_V,2);
IND_V=IND_V(:,2:end);

end