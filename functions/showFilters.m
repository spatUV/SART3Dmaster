function showFilters(VS)
% Function to show virtual source filters.

NLS = size(VS.renderer.Filters,1);
L = VS.method.data.L;
F = zeros(NLS,L);
I = VS.renderer.Iactive;
for n = 1:length(I)
    F(I(n),:) = VS.renderer.Filters{I(n)}.Filter;
end

figure();
imagesc(F)
xlabel('Coefficients')
ylabel('Loudspeakers');
    
