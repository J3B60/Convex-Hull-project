%Convex Hull Algorithm
%InputArray is in the form [[x1,y1];[x2,y2];...]
%where x1 and y1 are part of the co-ordinate (x1,y1) and (x2,y2) are of another

%CONVEX HULL function
function ResultArray = ConvexHull(ConvexHullInputArray)
    UH = UpperHull(ConvexHullInputArray)
    LH = LowerHull(ConvexHullInputArray)
    ResultArray = cat(1, UH(1:size(UH,1)-1,:), LH(1:size(LH,1)-1,:)) %concatinate to loop round and make circle
end
 
%Isleft - check is anti-clock turn from previous match
function Isleftreturn = Isleft(a,b,c)
    Isleftreturn = ((b(1)-a(1))*(c(2)-a(2))-(b(2)-a(2))*(c(1)-a(1)))>=0
end
 
%Upper Convex Hull
function UpperHullArray = UpperHull(UpperHullInputArray)
    UpperHullArray = UpperHullInputArray(1:3,:)
    for i=3:size(UpperHullInputArray,1)
        UpperHullArray = cat(1, UpperHullArray, UpperHullInputArray(i,:))
        while size(UpperHullArray, 1) > 2 && Isleft(UpperHullArray(size(UpperHullArray, 1)-2,:), UpperHullArray(size(UpperHullArray, 1)-1,:), UpperHullArray(size(UpperHullArray, 1),:)) == 1
            UpperHullArray(size(UpperHullArray, 1)-1,:) = []
        end
    end
end
 
%Lower Convex Hull
function LowerHullArray = LowerHull(LowerHullInputArray)
    Areversed = flipud(LowerHullInputArray)
    LowerHullArray = Areversed(1:3,:)
    for i=3:size(Areversed,1)
        LowerHullArray = cat(1, LowerHullArray, Areversed(i,:))
        while size(LowerHullArray,1) > 2 && Isleft(LowerHullArray(size(LowerHullArray,1)-2,:), LowerHullArray(size(LowerHullArray,1)-1,:), LowerHullArray(size(LowerHullArray,1),:)) == 1
            LowerHullArray(size(LowerHullArray,1)-1,:) = []
        end
    end
end
