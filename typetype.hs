data Point = Point Double Double deriving (Show,Eq) 
distance :: Point -> Point -> Double 
distance (Point x1 y1) (Point x2 y2) = sqrt ( (x1-x2)^2 + (y1 -y2)^2)
data Circle = Circle Point Double deriving (Show,Eq) 
area(Circle _ r) = pi * r ^2 
xCoord :: Circle -> Double
xCoord (Circle (Point x _) _ ) = x

origin :: Circle->Point 
origin (Circle point _ ) = point 



touchesOrigin :: Circle -> Bool 
touchesOrigin (Circle point r) =
      distance point (Point 0 0) <= r

-- our own version of maybe! 
data Possibly a = Only a | Zilch deriving (Show, Eq) 

firstElement :: [a] -> Possibly a 
firstElement [] = Zilch  
firstElement (x:_) = Only x

 
