function [scoreFinale] = matching2(mat1,mat2)

% INDICARE IL NUMERO DI CARATTERISTICHE CHE SI VUOLE UTILIZZARE
	matMatchA = mat1(1:26);
	matMatchB = mat2(1:26);
	

%SELEZIONARE LA FORMULA DI MATCHING
%   scoreFinale = sqrt(sum(((matMatchA - matMatchB).^2)./varianze1)); 	%distanza euclidea pesata
%   scoreFinale = sum((abs(matMatchA - matMatchB))./(sqrt(varianze1))); %distanza assoluta pesata
    scoreFinale = sum(abs(matMatchA -  matMatchB)); 					%distanza assoluta 
%   scoreFinale = sqrt(sum((matMatchA - matMatchB).^2)); 				%distanza euclidea

end