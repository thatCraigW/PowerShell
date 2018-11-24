$criteria= @("a","b")
$array1= @("a","b","c","d")
$array2= @("a","c","d","b")
$array3= @("a","e","c","d")

#'Check $array1 for $criteria'
-not @($criteria| where {$array1 -notcontains $_}).Count #should be True, contains "a" AND "b" in order

#'Check $array2 for $criteria'
-not @($criteria| where {$array2 -notcontains $_}).Count #should be True, contains "a" AND "b" out of order

#'Check $array3 for $criteria'
-not @($criteria| where {$array3 -notcontains $_}).Count #should be False, does not contain "b", only "a"