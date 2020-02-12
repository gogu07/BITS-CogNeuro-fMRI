function [A,B,D,T,G]=windowed_mean(a,b,d,t,g, window_size)
len=length(a)/window_size;
start=1;

%A=zeros(32, 30);
%B=zeros(32, 30);
%D=zeros(32, 30);
%T=zeros(32, 30);
%G=zeros(32, 30);

for i=1:len
A(:,i)=mean(a(:,start:(start+window_size-1))');
B(:,i)=mean(b(:,start:(start+window_size-1))');
D(:,i)=mean(d(:,start:(start+window_size-1))');
T(:,i)=mean(t(:,start:(start+window_size-1))');
G(:,i)=mean(g(:,start:(start+window_size-1))');
start=start+window_size;
end

end