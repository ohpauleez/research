% Paul deGrandis Drexel University, SERG
% Java loop normalization
% --based on previous work; see below--
% TXL 103a3 Translation, Java to C#
% Rihab Eltayeb, Sudan University, March 2005

% The base Java grammar
include "Java.Grm

%Find all loop blocks and normalize them using block rules
include "TransformAllLoops.Rul"

% Main translation rule 
function main
	replace [program] 
              	    % before adding braces
   	    construct NewProgram[program]
   	    	NewImportDeclaration
	        PHeader[changePackageToNamespace]
	                 TypeDeclr[changeClassHeader]
	                       	  [changeInterfaceHeader]
   	by
            NewProgram[addBraces]
end function
% add the optional braces when required
function addBraces %
replace [program] 
	NewImportDeclaration[repeat import_declaration]
	PHeader[package_header]	    
	TypeDeclr[repeat type_declaration]
	%construct Length[number]
	%	 _[length NewImportDeclaration]
	%where Length[> 0]
	by
	NewImportDeclaration
	PHeader	    
	'{
	    TypeDeclr
	'}
end function	 







% [8]-------------------------------------------------------------------------------
% to treat an empty body  
function translateEmptyBody
replace [class_body]
	'{
		;
	'}
	by
	'{
	'}
end function
% [9]-------------------------------------------------------------------------------
% to treat the body of a class 
function changeClassBody
replace [class_body]
	'{                                   
		ClassBodyDecls[repeat class_body_declaration]    
   	'} optSemiColon[opt ';]          
	export InitCalls[repeat declaration_or_statement]
		_%empty one
	by
	'{	
		 ClassBodyDecls[translateFieldDeclaration]
		 	       [translateInstanceInit]
		 	       [translateStaticInit]
		 	       [translateBodyMembers]
		 	        	
	'}optSemiColon
end function
% [10]-------------------------------------------------------------------------------
% inside the body
function translateBodyMembers
	replace [repeat class_body_declaration]                               
		ClassBodyDecl[class_body_declaration] 
		RemainingRepeatBodyDecl[repeat class_body_declaration]    
   	by
	 	ClassBodyDecl[translateMemberDeclaration]%type declaration
	 		     [translateMethodConstructor]   
    		RemainingRepeatBodyDecl[translateBodyMembers]
end function




