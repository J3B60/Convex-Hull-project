%Divide and Conquer Convex Hull
function DCConvexHullArray = DCConvexHull(DCConvexHullInputArray)
	if (size(DCConvexHullInputArray, 1) < 4 )%Min size = 4 , can be changed to whatever is suitable for input
		DCConvexHullArray = ConvexHull ( DCConvexHullInputArray )
	else
		[ArrayX, ArrayY] = Split(DCConvexHullInputArray)
		DCConvexHullArray = Merge (ConvexHull(ArrayX) , ConvexHull( ArrayY ))
	end
end

function [SplitReturnX , SplitReturnY] = Split(SplitInputArray)
	SplitReturnX = Split InputArray(1:floor(size(SplitInputArray,1)/2),:)
	SplitReturnY = Split InputArray(floor(size(SplitInputArray,1)/2)+1:end,:)
end

function MergeReturn = Merge (A, B)
	%Idea using IsLeftfunction
	%UpperTangent
	ResultA = MergeUpperTangent (A,B)
	%LowerTangent
	A = cat(1,A(1,:),A)
	B = cat(1,B,B(1,:))
	ResultB = MergeLowerTangent (A,B)
	MergeReturn = cat(1,ResultA,ResultB)
end

function MergeUpperTangentReturn = MergeUpperTangent (A,B)
	while(Isleft(B(1,:),A(end,:), A(end−1,:)) == 0 || Isleft(A(end,:),B(1,:), B(1+1,:)) == 1)%While there is still more to do
		while size(A,1) > 1 && Isleft(B(1,:), A(end,:), A(end−1,:)) == 0 %stating from B check 1st A and Next A
			A(end,:) = []
		end
		while size(B,1) > 1 && Isleft(A(end,:), B(1,:), B(1+1,:)) == 1 %If not left then isright
			B(1,:) = []
		end
	end
	MergeUpperTangentReturn = cat(1, A, B)
end

function MergeLowerTangentReturn = MergeLowerTangent(A,B)%Like MergeUpperTangent but opposite direction
	Arev = flipud(A)
	Brev = flipud(B)
	while(Isleft(Brev(1,:), Arev(end,:), Arev(end−1,:)) == 1 || Isleft(Arev(end,:), Brev(1,:), Brev(1+1,:)) == 0)%SWAPPED DIREC While there is still more to do
		while size(Arev, 1) > 1 && Isleft(Brev(1,:), Arev(end,:), Arev(end−1, :)) == 1 %SWAPPED DIRECTION
			% TangentPointA = A(end−1,:)
			Arev (end , : ) = [ ]
		end
		while size(Brev, 1) > 1 && Isleft(Arev(end, :), Brev(1,:), Brev(1+1,:)) == 0 %SWAPPED DIRECTION
			% TangentPointB = B(1+1,:)
			Brev(1,:) = []
		end
	end
	MergeLowerTangentReturn = cat(1,Brev,Arev)
	% MergeLowerTangentReturn = []
end