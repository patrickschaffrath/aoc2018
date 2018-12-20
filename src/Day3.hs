module Day3
    (day3
    ) where

import           Data.List
import           Data.Map   as Map (Map, alter, empty, foldl, lookup)
import           Data.Maybe


day3 :: IO ()
day3 = print (solveA input, solveB input)


solveA :: [((Int, Int), (Int, Int))] -> Int
solveA = overlapCount . overlap'


solveB :: [((Int, Int), (Int, Int))] -> Int
solveB x = wholeClaimIdx (claims x) (overlap' x)


overlap' :: [((Int, Int), (Int, Int))] -> Map (Int, Int) Int
overlap' x = overlap (claims x) empty


wholeClaimIdx :: [[(Int, Int)]] -> Map (Int, Int) Int -> Int
wholeClaimIdx xss m = (+1) $ fromJust $ findIndex lookupClaim xss
                      where
                        lookupClaim xs = foldl' (\acc x -> acc + fromJust (Map.lookup x m)) 0 xs == length xs


overlapCount :: Map (Int, Int) Int -> Int
overlapCount = Map.foldl fold 0
                where
                  fold acc x
                            | x > 1     = acc + 1
                            | otherwise = acc


overlap :: [[(Int, Int)]] -> Map (Int, Int) Int -> Map (Int, Int) Int
overlap [] m        = m
overlap (xs:xss) m  = overlap xss (foldl' (flip (alter inc)) m xs)
                        where inc Nothing  = Just 1
                              inc (Just x) = Just $ x + 1


claims :: [((Int, Int), (Int, Int))] -> [[(Int, Int)]]
claims = coords . ranges


coords :: [([Int], [Int])] -> [[(Int, Int)]]
coords [] = []
coords (x:xs) = uncurry coords' x : coords xs
                  where coords' _ []      = []
                        coords' xs (y:ys) = zip xs (repeat y) ++ coords' xs ys


ranges :: [((Int, Int), (Int, Int))] -> [([Int], [Int])]
ranges xs = zip xVals yVals
              where
                xVals = map (\x -> [fst (fst x) +1..fst (fst x) + fst (snd x)]) xs
                yVals = map (\y -> [snd (fst y) +1..snd (fst y) + snd (snd y)]) xs


input =
  [((265,241),(16,26)),
  ((584,382),(12,8)),
  ((584,823),(22,10)),
  ((336,138),(26,22)),
  ((527,903),(26,18)),
  ((596,224),(23,20)),
  ((770,344),(15,12)),
  ((191,889),(17,11)),
  ((493,316),(12,19)),
  ((648,614),(26,28)),
  ((217,27),(25,20)),
  ((819,550),(16,12)),
  ((314,74),(18,25)),
  ((844,633),(22,16)),
  ((793,382),(11,18)),
  ((899,263),(16,14)),
  ((713,844),(11,21)),
  ((502,903),(19,12)),
  ((434,163),(29,24)),
  ((307,339),(23,15)),
  ((683,931),(10,22)),
  ((950,568),(23,15)),
  ((514,250),(11,19)),
  ((383,822),(28,20)),
  ((558,319),(13,22)),
  ((461,984),(25,11)),
  ((594,218),(18,14)),
  ((852,877),(18,29)),
  ((683,369),(22,29)),
  ((538,120),(20,24)),
  ((961,406),(26,27)),
  ((124,832),(11,15)),
  ((500,215),(16,22)),
  ((166,104),(12,23)),
  ((912,502),(22,16)),
  ((752,577),(18,10)),
  ((456,111),(11,20)),
  ((238,927),(18,14)),
  ((530,477),(20,13)),
  ((70,180),(26,22)),
  ((522,686),(17,20)),
  ((270,785),(17,23)),
  ((545,455),(24,15)),
  ((11,291),(10,18)),
  ((809,550),(21,12)),
  ((714,57),(19,12)),
  ((291,699),(29,17)),
  ((156,539),(25,26)),
  ((435,189),(13,16)),
  ((746,608),(26,16)),
  ((509,397),(15,4)),
  ((152,875),(22,29)),
  ((929,895),(22,18)),
  ((18,458),(19,26)),
  ((22,773),(28,14)),
  ((438,487),(17,11)),
  ((430,863),(27,13)),
  ((642,287),(19,25)),
  ((407,951),(13,4)),
  ((163,271),(18,19)),
  ((648,746),(11,27)),
  ((712,509),(21,23)),
  ((905,910),(29,25)),
  ((56,328),(25,24)),
  ((761,688),(11,18)),
  ((897,165),(29,25)),
  ((892,899),(19,28)),
  ((407,722),(12,25)),
  ((521,885),(20,26)),
  ((505,737),(24,10)),
  ((181,333),(24,16)),
  ((960,55),(11,24)),
  ((539,850),(23,28)),
  ((880,166),(13,13)),
  ((218,500),(18,18)),
  ((451,553),(25,22)),
  ((786,107),(20,13)),
  ((615,282),(22,15)),
  ((147,430),(25,29)),
  ((629,98),(18,25)),
  ((231,830),(17,13)),
  ((873,104),(18,11)),
  ((674,811),(21,13)),
  ((58,287),(13,29)),
  ((802,211),(18,11)),
  ((843,467),(21,23)),
  ((187,576),(24,21)),
  ((762,618),(10,20)),
  ((490,550),(12,13)),
  ((575,305),(12,25)),
  ((32,89),(16,20)),
  ((10,243),(23,14)),
  ((50,847),(15,28)),
  ((817,539),(17,29)),
  ((622,540),(12,20)),
  ((574,829),(23,10)),
  ((224,638),(18,23)),
  ((367,753),(29,14)),
  ((134,694),(17,11)),
  ((165,757),(14,29)),
  ((41,811),(13,22)),
  ((621,906),(25,16)),
  ((728,745),(14,26)),
  ((723,65),(24,16)),
  ((536,93),(10,22)),
  ((871,204),(22,25)),
  ((372,276),(19,21)),
  ((24,77),(29,16)),
  ((292,585),(26,16)),
  ((621,346),(11,15)),
  ((463,726),(20,22)),
  ((802,100),(19,11)),
  ((626,726),(23,16)),
  ((405,944),(21,20)),
  ((954,410),(13,22)),
  ((244,839),(11,26)),
  ((65,272),(29,10)),
  ((476,382),(28,10)),
  ((794,319),(18,19)),
  ((115,682),(24,14)),
  ((818,612),(16,28)),
  ((7,755),(21,24)),
  ((365,404),(14,21)),
  ((584,218),(29,20)),
  ((41,608),(20,21)),
  ((4,217),(16,16)),
  ((894,723),(21,24)),
  ((125,716),(24,22)),
  ((392,211),(23,27)),
  ((429,16),(27,16)),
  ((350,530),(26,28)),
  ((767,626),(12,20)),
  ((916,120),(24,27)),
  ((287,878),(20,10)),
  ((434,445),(21,21)),
  ((115,683),(22,13)),
  ((583,875),(25,28)),
  ((87,171),(12,23)),
  ((328,136),(29,17)),
  ((860,485),(10,10)),
  ((787,287),(15,11)),
  ((500,845),(12,24)),
  ((147,252),(10,13)),
  ((399,78),(16,14)),
  ((780,412),(25,13)),
  ((193,792),(19,29)),
  ((195,718),(20,10)),
  ((811,550),(21,19)),
  ((906,69),(14,21)),
  ((542,964),(18,19)),
  ((225,412),(25,22)),
  ((763,42),(19,11)),
  ((299,607),(28,13)),
  ((781,283),(29,19)),
  ((110,46),(23,10)),
  ((769,108),(20,10)),
  ((916,713),(20,22)),
  ((686,875),(28,17)),
  ((749,698),(13,22)),
  ((958,203),(11,11)),
  ((771,97),(28,18)),
  ((46,147),(11,20)),
  ((340,346),(26,25)),
  ((332,340),(14,22)),
  ((217,878),(14,24)),
  ((377,80),(29,16)),
  ((135,164),(14,18)),
  ((578,235),(23,27)),
  ((938,68),(11,12)),
  ((315,397),(19,26)),
  ((218,425),(19,27)),
  ((125,688),(10,27)),
  ((337,696),(29,14)),
  ((851,834),(10,23)),
  ((265,901),(18,21)),
  ((369,796),(23,24)),
  ((207,884),(28,16)),
  ((387,607),(18,22)),
  ((518,182),(18,25)),
  ((512,775),(13,11)),
  ((21,572),(15,27)),
  ((526,848),(14,18)),
  ((636,973),(19,24)),
  ((468,469),(10,23)),
  ((371,102),(15,27)),
  ((56,270),(26,22)),
  ((487,329),(25,17)),
  ((212,964),(16,15)),
  ((602,538),(19,18)),
  ((610,116),(26,28)),
  ((163,419),(22,11)),
  ((787,310),(18,25)),
  ((396,781),(13,17)),
  ((582,379),(22,18)),
  ((385,764),(10,18)),
  ((15,222),(11,10)),
  ((185,824),(14,11)),
  ((365,465),(21,13)),
  ((278,534),(20,19)),
  ((945,545),(20,28)),
  ((831,304),(20,25)),
  ((94,630),(15,26)),
  ((352,792),(25,14)),
  ((404,817),(15,18)),
  ((521,895),(26,12)),
  ((398,426),(17,20)),
  ((462,118),(21,18)),
  ((780,316),(19,13)),
  ((837,29),(16,25)),
  ((491,536),(20,19)),
  ((463,389),(25,26)),
  ((704,547),(17,21)),
  ((737,464),(14,23)),
  ((852,681),(19,14)),
  ((754,321),(20,16)),
  ((821,495),(11,24)),
  ((909,961),(20,21)),
  ((924,403),(19,12)),
  ((915,136),(12,21)),
  ((177,384),(12,20)),
  ((859,216),(19,14)),
  ((772,705),(25,12)),
  ((266,76),(22,14)),
  ((398,206),(22,22)),
  ((526,905),(23,26)),
  ((311,593),(22,23)),
  ((456,566),(20,24)),
  ((808,294),(11,10)),
  ((831,43),(24,24)),
  ((43,764),(20,29)),
  ((529,25),(13,29)),
  ((285,698),(10,16)),
  ((233,848),(26,21)),
  ((65,185),(13,22)),
  ((959,74),(18,20)),
  ((849,398),(26,19)),
  ((88,492),(26,11)),
  ((680,389),(17,29)),
  ((802,81),(24,19)),
  ((454,573),(15,25)),
  ((149,757),(16,27)),
  ((965,680),(24,24)),
  ((82,589),(16,16)),
  ((656,528),(23,23)),
  ((427,647),(24,29)),
  ((5,452),(26,21)),
  ((701,527),(17,13)),
  ((656,527),(14,27)),
  ((6,493),(14,29)),
  ((143,505),(21,17)),
  ((257,736),(15,29)),
  ((499,188),(28,20)),
  ((748,568),(24,20)),
  ((567,222),(23,12)),
  ((308,571),(12,14)),
  ((512,232),(11,22)),
  ((123,57),(27,25)),
  ((185,948),(15,28)),
  ((844,747),(21,26)),
  ((249,934),(25,23)),
  ((232,440),(15,14)),
  ((393,403),(15,27)),
  ((390,716),(21,17)),
  ((227,856),(15,10)),
  ((175,877),(12,16)),
  ((857,535),(11,25)),
  ((838,393),(12,14)),
  ((624,331),(12,21)),
  ((195,150),(24,14)),
  ((887,538),(23,27)),
  ((201,496),(24,20)),
  ((322,122),(25,25)),
  ((14,96),(28,10)),
  ((240,430),(19,25)),
  ((199,536),(26,24)),
  ((691,472),(26,22)),
  ((252,580),(25,13)),
  ((124,609),(26,28)),
  ((927,559),(14,11)),
  ((173,858),(21,14)),
  ((679,810),(10,15)),
  ((794,669),(15,27)),
  ((509,292),(23,26)),
  ((449,205),(11,23)),
  ((263,329),(24,23)),
  ((667,571),(29,25)),
  ((127,307),(21,14)),
  ((630,112),(23,23)),
  ((456,254),(11,13)),
  ((601,945),(20,19)),
  ((622,239),(18,15)),
  ((496,884),(20,14)),
  ((7,758),(27,27)),
  ((528,676),(12,21)),
  ((691,550),(15,17)),
  ((332,635),(26,26)),
  ((536,363),(27,29)),
  ((791,656),(16,23)),
  ((892,839),(6,11)),
  ((449,32),(22,24)),
  ((450,315),(11,23)),
  ((229,943),(26,15)),
  ((796,785),(11,18)),
  ((816,338),(24,12)),
  ((245,944),(10,29)),
  ((43,757),(20,26)),
  ((938,59),(12,14)),
  ((182,615),(27,16)),
  ((614,429),(25,21)),
  ((819,925),(23,23)),
  ((209,769),(20,24)),
  ((786,978),(25,15)),
  ((951,846),(25,27)),
  ((695,26),(12,11)),
  ((843,891),(23,10)),
  ((139,627),(21,28)),
  ((716,303),(23,24)),
  ((612,377),(22,12)),
  ((853,663),(11,25)),
  ((838,639),(14,24)),
  ((629,934),(24,16)),
  ((866,809),(12,27)),
  ((44,801),(21,18)),
  ((949,417),(22,17)),
  ((967,573),(15,19)),
  ((64,258),(19,22)),
  ((449,717),(21,17)),
  ((191,866),(15,27)),
  ((423,11),(24,18)),
  ((190,702),(21,24)),
  ((908,570),(15,28)),
  ((197,148),(27,14)),
  ((587,220),(28,17)),
  ((713,232),(25,16)),
  ((337,427),(21,20)),
  ((170,485),(17,14)),
  ((506,898),(25,19)),
  ((720,200),(14,12)),
  ((13,694),(28,24)),
  ((9,485),(16,15)),
  ((383,126),(22,14)),
  ((852,667),(3,10)),
  ((367,932),(11,25)),
  ((87,753),(26,26)),
  ((160,608),(29,24)),
  ((370,944),(10,22)),
  ((904,900),(18,19)),
  ((401,114),(28,22)),
  ((498,745),(24,17)),
  ((214,748),(22,23)),
  ((161,6),(11,20)),
  ((980,165),(12,18)),
  ((397,818),(10,10)),
  ((481,886),(28,12)),
  ((400,82),(13,13)),
  ((298,593),(24,28)),
  ((500,79),(10,27)),
  ((639,512),(20,27)),
  ((508,100),(26,22)),
  ((780,237),(23,21)),
  ((356,454),(11,10)),
  ((39,413),(19,19)),
  ((820,626),(20,17)),
  ((442,477),(11,12)),
  ((898,906),(28,14)),
  ((154,423),(29,14)),
  ((540,409),(28,17)),
  ((507,395),(22,10)),
  ((361,602),(21,20)),
  ((14,105),(14,12)),
  ((515,904),(14,18)),
  ((204,880),(18,24)),
  ((333,584),(29,22)),
  ((511,309),(11,27)),
  ((260,240),(14,12)),
  ((629,368),(16,24)),
  ((128,43),(13,22)),
  ((59,186),(13,27)),
  ((731,186),(23,15)),
  ((382,837),(17,4)),
  ((508,536),(15,11)),
  ((690,145),(18,17)),
  ((381,496),(25,25)),
  ((812,107),(8,11)),
  ((736,411),(27,19)),
  ((610,926),(29,23)),
  ((469,561),(10,27)),
  ((480,540),(10,25)),
  ((824,850),(29,20)),
  ((780,534),(29,17)),
  ((562,25),(23,19)),
  ((543,7),(21,11)),
  ((316,343),(29,12)),
  ((196,851),(20,24)),
  ((436,674),(14,15)),
  ((714,329),(21,11)),
  ((400,923),(28,27)),
  ((372,469),(10,17)),
  ((15,261),(15,12)),
  ((791,837),(22,24)),
  ((153,941),(21,25)),
  ((129,146),(20,28)),
  ((501,369),(23,23)),
  ((899,238),(28,29)),
  ((523,781),(29,16)),
  ((651,918),(21,13)),
  ((580,12),(25,28)),
  ((560,81),(19,29)),
  ((243,202),(19,19)),
  ((59,919),(28,20)),
  ((377,473),(20,17)),
  ((713,732),(18,18)),
  ((160,598),(16,11)),
  ((440,663),(26,10)),
  ((114,588),(12,14)),
  ((282,797),(24,22)),
  ((623,729),(28,20)),
  ((372,393),(13,19)),
  ((385,663),(28,13)),
  ((923,77),(12,16)),
  ((302,795),(13,19)),
  ((13,728),(23,16)),
  ((206,885),(19,24)),
  ((166,281),(16,13)),
  ((837,645),(27,13)),
  ((528,901),(19,15)),
  ((213,613),(23,26)),
  ((190,727),(29,17)),
  ((801,108),(12,21)),
  ((846,791),(19,25)),
  ((630,683),(27,12)),
  ((641,639),(15,19)),
  ((806,102),(22,20)),
  ((621,477),(26,16)),
  ((186,815),(22,12)),
  ((55,189),(11,11)),
  ((657,912),(12,18)),
  ((924,246),(19,16)),
  ((423,424),(14,28)),
  ((392,80),(14,12)),
  ((23,790),(22,27)),
  ((192,952),(25,16)),
  ((24,254),(10,14)),
  ((967,578),(26,27)),
  ((747,348),(7,4)),
  ((104,626),(10,21)),
  ((799,16),(10,13)),
  ((795,315),(29,26)),
  ((958,199),(19,20)),
  ((183,720),(23,26)),
  ((513,457),(29,21)),
  ((966,674),(16,13)),
  ((669,657),(24,12)),
  ((508,126),(18,29)),
  ((749,192),(24,25)),
  ((463,106),(24,12)),
  ((387,789),(17,20)),
  ((683,835),(16,24)),
  ((70,570),(24,26)),
  ((178,841),(10,11)),
  ((492,812),(27,29)),
  ((98,172),(15,15)),
  ((871,738),(21,17)),
  ((942,334),(18,27)),
  ((511,892),(17,16)),
  ((502,728),(26,25)),
  ((527,783),(11,17)),
  ((971,679),(15,17)),
  ((685,518),(27,27)),
  ((385,686),(13,26)),
  ((148,567),(25,25)),
  ((413,243),(20,28)),
  ((518,389),(4,15)),
  ((188,456),(20,12)),
  ((442,605),(15,11)),
  ((285,815),(18,22)),
  ((655,433),(13,12)),
  ((612,888),(21,28)),
  ((632,760),(20,25)),
  ((946,417),(25,10)),
  ((275,176),(24,14)),
  ((972,514),(21,28)),
  ((81,646),(17,14)),
  ((77,349),(12,26)),
  ((457,612),(10,25)),
  ((877,678),(24,19)),
  ((232,0),(11,26)),
  ((828,562),(20,10)),
  ((425,63),(12,22)),
  ((822,325),(25,15)),
  ((646,934),(24,20)),
  ((414,873),(27,29)),
  ((503,494),(27,19)),
  ((954,679),(26,13)),
  ((818,547),(20,11)),
  ((807,654),(12,24)),
  ((182,422),(27,27)),
  ((379,248),(13,29)),
  ((335,312),(27,12)),
  ((854,729),(21,21)),
  ((912,253),(23,22)),
  ((86,60),(11,12)),
  ((172,822),(21,16)),
  ((142,564),(13,26)),
  ((515,639),(16,12)),
  ((468,60),(12,24)),
  ((217,850),(21,20)),
  ((844,635),(23,13)),
  ((494,325),(22,22)),
  ((757,313),(11,17)),
  ((504,594),(28,17)),
  ((771,94),(11,29)),
  ((703,826),(11,16)),
  ((364,351),(21,11)),
  ((80,372),(21,10)),
  ((509,291),(27,14)),
  ((785,671),(23,23)),
  ((39,141),(19,25)),
  ((680,523),(26,18)),
  ((479,724),(24,25)),
  ((374,446),(15,17)),
  ((187,953),(13,13)),
  ((324,430),(26,25)),
  ((774,85),(18,14)),
  ((811,275),(20,18)),
  ((587,598),(29,22)),
  ((960,68),(16,27)),
  ((635,288),(14,14)),
  ((337,576),(27,10)),
  ((478,710),(14,26)),
  ((59,310),(19,24)),
  ((493,882),(26,20)),
  ((688,455),(17,28)),
  ((509,779),(16,13)),
  ((352,457),(16,16)),
  ((556,134),(29,13)),
  ((615,728),(10,20)),
  ((860,434),(24,15)),
  ((636,226),(29,16)),
  ((864,904),(11,16)),
  ((50,273),(11,15)),
  ((616,717),(10,26)),
  ((617,428),(26,21)),
  ((880,820),(14,22)),
  ((650,77),(12,16)),
  ((881,690),(11,21)),
  ((584,209),(28,14)),
  ((485,553),(20,18)),
  ((156,4),(26,29)),
  ((199,403),(17,17)),
  ((680,485),(29,25)),
  ((925,264),(22,29)),
  ((780,90),(27,21)),
  ((137,167),(28,26)),
  ((929,228),(19,12)),
  ((240,436),(22,20)),
  ((798,511),(17,21)),
  ((892,787),(27,10)),
  ((822,598),(25,29)),
  ((520,148),(13,24)),
  ((839,721),(17,24)),
  ((569,888),(26,13)),
  ((246,914),(29,27)),
  ((162,910),(19,10)),
  ((457,539),(27,17)),
  ((22,111),(28,24)),
  ((455,967),(18,22)),
  ((63,175),(16,17)),
  ((91,53),(12,18)),
  ((911,873),(23,14)),
  ((887,666),(21,18)),
  ((213,511),(28,18)),
  ((186,713),(24,11)),
  ((459,286),(20,20)),
  ((716,576),(17,24)),
  ((129,552),(15,29)),
  ((551,223),(27,22)),
  ((890,177),(28,27)),
  ((559,954),(11,23)),
  ((97,496),(17,11)),
  ((146,587),(13,11)),
  ((310,544),(14,11)),
  ((282,163),(16,14)),
  ((634,444),(27,20)),
  ((689,409),(18,26)),
  ((344,604),(22,14)),
  ((155,820),(10,21)),
  ((259,952),(13,26)),
  ((654,761),(19,19)),
  ((287,810),(27,23)),
  ((760,596),(11,29)),
  ((368,539),(21,27)),
  ((792,298),(28,23)),
  ((251,392),(18,13)),
  ((149,455),(16,24)),
  ((873,900),(22,10)),
  ((93,655),(20,15)),
  ((431,656),(20,21)),
  ((416,393),(23,11)),
  ((841,637),(11,27)),
  ((628,93),(21,22)),
  ((227,970),(22,26)),
  ((967,665),(11,22)),
  ((370,958),(10,15)),
  ((550,59),(26,28)),
  ((673,222),(22,13)),
  ((461,551),(21,14)),
  ((290,594),(19,12)),
  ((584,284),(29,26)),
  ((117,600),(23,11)),
  ((70,452),(21,12)),
  ((508,261),(10,10)),
  ((330,926),(25,13)),
  ((939,660),(20,27)),
  ((467,628),(29,21)),
  ((238,417),(22,23)),
  ((297,728),(28,18)),
  ((385,825),(27,23)),
  ((360,457),(24,11)),
  ((975,157),(19,17)),
  ((453,319),(4,14)),
  ((243,690),(22,13)),
  ((389,31),(23,23)),
  ((208,971),(19,21)),
  ((145,633),(12,23)),
  ((736,480),(25,17)),
  ((343,166),(20,17)),
  ((511,323),(14,26)),
  ((62,304),(20,21)),
  ((957,303),(23,29)),
  ((130,739),(29,28)),
  ((977,574),(18,13)),
  ((675,553),(10,22)),
  ((52,146),(13,10)),
  ((938,659),(16,17)),
  ((318,61),(26,19)),
  ((731,245),(24,15)),
  ((673,537),(11,11)),
  ((780,527),(11,21)),
  ((103,970),(22,19)),
  ((943,669),(17,20)),
  ((280,888),(10,28)),
  ((381,351),(16,28)),
  ((214,145),(10,20)),
  ((243,376),(27,28)),
  ((866,783),(11,14)),
  ((705,432),(18,11)),
  ((523,678),(16,24)),
  ((171,824),(17,19)),
  ((476,86),(7,10)),
  ((661,645),(16,27)),
  ((388,930),(24,15)),
  ((675,863),(24,16)),
  ((525,37),(26,26)),
  ((427,54),(16,27)),
  ((708,804),(13,29)),
  ((61,236),(25,15)),
  ((56,797),(25,29)),
  ((773,714),(23,16)),
  ((801,397),(11,10)),
  ((633,637),(28,21)),
  ((869,673),(12,13)),
  ((258,582),(10,13)),
  ((546,448),(18,23)),
  ((962,59),(6,16)),
  ((922,84),(13,23)),
  ((761,588),(25,29)),
  ((730,436),(13,11)),
  ((43,303),(27,28)),
  ((896,902),(29,29)),
  ((604,126),(25,24)),
  ((377,465),(13,23)),
  ((146,654),(13,25)),
  ((425,202),(22,12)),
  ((718,847),(16,23)),
  ((589,219),(14,12)),
  ((168,855),(29,23)),
  ((797,10),(10,27)),
  ((704,29),(18,26)),
  ((297,549),(24,20)),
  ((51,835),(16,17)),
  ((598,536),(25,26)),
  ((786,703),(15,26)),
  ((171,267),(15,21)),
  ((129,450),(24,22)),
  ((894,58),(23,12)),
  ((7,558),(27,19)),
  ((804,775),(16,12)),
  ((629,9),(26,19)),
  ((503,311),(28,13)),
  ((975,224),(13,13)),
  ((135,11),(20,16)),
  ((184,472),(25,23)),
  ((380,579),(17,22)),
  ((328,600),(21,25)),
  ((803,518),(13,15)),
  ((143,300),(29,23)),
  ((46,845),(29,18)),
  ((71,459),(26,16)),
  ((405,423),(18,16)),
  ((302,127),(29,16)),
  ((761,624),(15,26)),
  ((795,111),(22,26)),
  ((909,717),(11,26)),
  ((75,914),(25,21)),
  ((786,914),(19,12)),
  ((247,662),(28,20)),
  ((222,504),(22,20)),
  ((631,981),(24,15)),
  ((633,436),(28,11)),
  ((413,717),(21,14)),
  ((58,241),(26,23)),
  ((48,217),(18,18)),
  ((393,823),(26,20)),
  ((928,530),(24,18)),
  ((712,642),(19,14)),
  ((231,534),(21,13)),
  ((314,811),(15,21)),
  ((780,856),(29,23)),
  ((161,121),(10,14)),
  ((687,807),(17,19)),
  ((360,680),(13,24)),
  ((177,873),(23,25)),
  ((840,917),(15,20)),
  ((863,809),(12,21)),
  ((868,154),(19,24)),
  ((719,24),(25,16)),
  ((20,97),(11,21)),
  ((937,332),(27,24)),
  ((383,41),(24,17)),
  ((845,664),(14,17)),
  ((386,581),(16,11)),
  ((835,618),(21,29)),
  ((29,697),(20,18)),
  ((514,743),(16,12)),
  ((69,729),(27,29)),
  ((537,133),(26,21)),
  ((243,74),(26,19)),
  ((964,220),(28,19)),
  ((146,944),(11,25)),
  ((157,621),(29,22)),
  ((199,558),(26,13)),
  ((472,934),(6,11)),
  ((473,726),(11,21)),
  ((899,19),(16,11)),
  ((434,381),(21,28)),
  ((368,483),(16,20)),
  ((750,793),(18,17)),
  ((905,174),(16,28)),
  ((648,16),(13,20)),
  ((387,678),(21,12)),
  ((662,561),(19,17)),
  ((457,175),(22,28)),
  ((456,447),(17,20)),
  ((692,152),(22,21)),
  ((62,733),(13,24)),
  ((29,480),(14,20)),
  ((849,367),(28,16)),
  ((457,221),(19,22)),
  ((155,548),(23,24)),
  ((794,922),(28,16)),
  ((152,579),(19,10)),
  ((176,887),(24,13)),
  ((920,68),(23,17)),
  ((769,333),(12,26)),
  ((256,356),(15,17)),
  ((843,812),(29,15)),
  ((48,838),(13,18)),
  ((626,296),(18,11)),
  ((196,441),(12,23)),
  ((757,464),(11,20)),
  ((527,694),(24,21)),
  ((513,45),(22,19)),
  ((377,386),(29,21)),
  ((61,842),(16,14)),
  ((814,859),(18,11)),
  ((845,282),(27,23)),
  ((148,551),(29,19)),
  ((491,187),(18,25)),
  ((288,141),(28,25)),
  ((385,745),(11,27)),
  ((363,9),(23,29)),
  ((119,149),(19,27)),
  ((336,301),(26,15)),
  ((31,122),(28,28)),
  ((563,0),(23,15)),
  ((967,144),(21,26)),
  ((164,745),(15,15)),
  ((967,574),(29,22)),
  ((411,266),(13,21)),
  ((189,374),(26,12)),
  ((847,537),(20,21)),
  ((440,560),(15,10)),
  ((75,734),(14,28)),
  ((805,863),(19,23)),
  ((46,422),(20,18)),
  ((363,691),(27,23)),
  ((681,574),(16,24)),
  ((975,353),(16,11)),
  ((764,874),(25,29)),
  ((421,109),(21,29)),
  ((251,284),(10,18)),
  ((512,40),(25,25)),
  ((942,409),(29,25)),
  ((296,348),(25,20)),
  ((738,311),(29,28)),
  ((341,854),(22,25)),
  ((443,670),(20,29)),
  ((111,912),(25,13)),
  ((542,106),(14,17)),
  ((538,317),(21,25)),
  ((954,912),(25,23)),
  ((30,190),(18,27)),
  ((655,228),(25,12)),
  ((775,406),(29,20)),
  ((95,104),(11,14)),
  ((821,278),(18,23)),
  ((268,338),(14,6)),
  ((402,595),(26,25)),
  ((485,3),(27,22)),
  ((516,741),(18,22)),
  ((575,320),(24,14)),
  ((722,611),(15,15)),
  ((171,954),(26,10)),
  ((631,933),(24,21)),
  ((45,714),(21,20)),
  ((441,103),(23,21)),
  ((334,754),(17,22)),
  ((230,17),(20,15)),
  ((348,543),(14,12)),
  ((978,561),(16,16)),
  ((927,407),(8,4)),
  ((886,513),(26,29)),
  ((640,927),(23,26)),
  ((558,838),(20,13)),
  ((63,132),(10,21)),
  ((801,253),(21,10)),
  ((739,341),(19,20)),
  ((888,59),(24,14)),
  ((444,607),(15,24)),
  ((327,584),(25,25)),
  ((598,224),(3,7)),
  ((407,827),(18,11)),
  ((630,622),(25,26)),
  ((129,302),(29,26)),
  ((491,768),(24,22)),
  ((154,255),(11,22)),
  ((256,184),(18,19)),
  ((336,173),(12,15)),
  ((174,950),(26,16)),
  ((873,681),(19,17)),
  ((119,63),(20,16)),
  ((834,831),(18,13)),
  ((566,427),(18,22)),
  ((640,27),(12,15)),
  ((163,907),(27,16)),
  ((894,783),(14,25)),
  ((915,283),(12,21)),
  ((660,290),(20,25)),
  ((286,510),(27,22)),
  ((627,682),(26,10)),
  ((724,613),(10,8)),
  ((817,502),(17,18)),
  ((888,562),(26,19)),
  ((825,896),(12,15)),
  ((9,286),(26,21)),
  ((95,973),(19,14)),
  ((476,460),(19,19)),
  ((300,515),(22,21)),
  ((29,597),(17,12)),
  ((586,218),(17,19)),
  ((32,733),(24,23)),
  ((297,882),(19,25)),
  ((316,596),(27,17)),
  ((975,536),(16,29)),
  ((650,509),(29,20)),
  ((802,908),(26,13)),
  ((122,294),(18,27)),
  ((511,498),(26,16)),
  ((16,516),(15,19)),
  ((498,381),(29,29)),
  ((133,165),(14,11)),
  ((700,481),(11,25)),
  ((402,513),(23,23)),
  ((902,55),(23,25)),
  ((247,186),(16,10)),
  ((760,117),(16,19)),
  ((215,973),(7,16)),
  ((788,957),(25,22)),
  ((544,482),(24,12)),
  ((202,596),(16,15)),
  ((979,133),(12,23)),
  ((217,138),(17,10)),
  ((902,43),(20,27)),
  ((25,428),(22,26)),
  ((485,360),(17,18)),
  ((594,950),(28,28)),
  ((90,947),(14,29)),
  ((528,817),(21,24)),
  ((46,787),(25,19)),
  ((255,338),(20,21)),
  ((245,466),(14,17)),
  ((361,663),(18,20)),
  ((682,495),(16,13)),
  ((534,477),(19,19)),
  ((459,722),(18,20)),
  ((600,224),(26,29)),
  ((762,341),(14,23)),
  ((593,172),(15,25)),
  ((449,295),(25,26)),
  ((908,716),(12,23)),
  ((140,871),(24,11)),
  ((106,508),(16,11)),
  ((250,674),(24,28)),
  ((880,680),(10,19)),
  ((285,696),(22,26)),
  ((462,486),(25,13)),
  ((838,969),(24,27)),
  ((636,88),(18,26)),
  ((852,723),(24,18)),
  ((361,838),(23,27)),
  ((686,666),(23,24)),
  ((737,724),(8,9)),
  ((957,582),(17,27)),
  ((466,928),(22,23)),
  ((526,189),(15,21)),
  ((331,342),(15,13)),
  ((30,827),(22,16)),
  ((841,813),(6,12)),
  ((865,808),(27,14)),
  ((687,408),(23,29)),
  ((546,357),(10,23)),
  ((965,424),(22,24)),
  ((373,182),(26,27)),
  ((507,24),(25,20)),
  ((327,391),(24,18)),
  ((520,700),(13,25)),
  ((828,379),(12,27)),
  ((460,585),(29,15)),
  ((0,862),(27,27)),
  ((140,952),(22,19)),
  ((509,675),(14,12)),
  ((922,649),(19,18)),
  ((255,204),(14,15)),
  ((446,889),(11,20)),
  ((427,687),(28,20)),
  ((964,925),(16,13)),
  ((393,869),(19,24)),
  ((442,455),(29,23)),
  ((120,518),(25,21)),
  ((474,83),(13,19)),
  ((31,233),(22,25)),
  ((911,51),(25,20)),
  ((242,408),(10,27)),
  ((695,14),(18,14)),
  ((839,458),(21,14)),
  ((934,894),(27,19)),
  ((854,781),(20,11)),
  ((757,48),(13,11)),
  ((4,259),(29,19)),
  ((463,829),(15,16)),
  ((369,934),(6,14)),
  ((782,714),(15,23)),
  ((355,783),(24,22)),
  ((206,374),(25,24)),
  ((389,768),(11,28)),
  ((149,286),(22,16)),
  ((746,461),(16,14)),
  ((763,626),(28,13)),
  ((874,908),(23,12)),
  ((481,935),(26,26)),
  ((802,239),(27,17)),
  ((936,401),(14,19)),
  ((909,648),(16,13)),
  ((567,425),(25,13)),
  ((129,315),(11,15)),
  ((858,406),(20,16)),
  ((912,703),(23,26)),
  ((104,488),(10,22)),
  ((185,831),(28,29)),
  ((765,985),(20,9)),
  ((923,275),(12,28)),
  ((533,182),(11,27)),
  ((451,549),(13,14)),
  ((715,304),(28,21)),
  ((171,244),(12,22)),
  ((10,74),(20,20)),
  ((448,570),(10,19)),
  ((634,532),(16,23)),
  ((614,974),(22,10)),
  ((840,754),(16,10)),
  ((216,159),(22,10)),
  ((455,234),(16,25)),
  ((164,597),(27,18)),
  ((806,201),(10,29)),
  ((585,235),(25,29)),
  ((615,424),(17,27)),
  ((124,835),(28,14)),
  ((531,599),(23,29)),
  ((941,189),(14,23)),
  ((94,970),(12,16)),
  ((930,402),(10,17)),
  ((640,531),(16,26)),
  ((379,833),(26,14)),
  ((465,488),(11,8)),
  ((136,72),(12,13)),
  ((511,828),(20,22)),
  ((457,72),(17,10)),
  ((207,153),(13,19)),
  ((225,700),(23,22)),
  ((159,838),(18,14)),
  ((340,783),(28,15)),
  ((276,535),(13,11)),
  ((483,76),(20,11)),
  ((639,805),(26,16)),
  ((106,533),(25,27)),
  ((173,713),(27,16)),
  ((196,770),(21,28)),
  ((833,872),(28,27)),
  ((870,811),(12,26)),
  ((323,911),(22,23)),
  ((399,721),(18,11)),
  ((763,980),(26,18)),
  ((16,760),(24,16)),
  ((194,748),(25,29)),
  ((26,595),(16,24)),
  ((724,227),(11,26)),
  ((686,505),(23,22)),
  ((266,737),(11,27)),
  ((810,106),(27,24)),
  ((744,242),(17,19)),
  ((688,220),(16,17)),
  ((701,468),(19,11)),
  ((180,383),(11,22)),
  ((23,468),(14,28)),
  ((615,402),(28,15)),
  ((172,325),(10,29)),
  ((35,204),(16,13)),
  ((96,885),(27,29)),
  ((391,850),(18,24)),
  ((699,222),(10,21)),
  ((852,346),(13,22)),
  ((4,534),(16,21)),
  ((482,706),(13,20)),
  ((311,162),(27,24)),
  ((686,948),(10,16)),
  ((825,810),(29,21)),
  ((258,470),(24,13)),
  ((139,310),(27,29)),
  ((959,326),(19,23)),
  ((250,175),(13,17)),
  ((306,554),(10,20)),
  ((499,748),(25,19)),
  ((690,521),(17,13)),
  ((831,634),(13,21)),
  ((245,539),(24,10)),
  ((72,651),(16,12)),
  ((520,99),(29,23)),
  ((778,154),(21,23)),
  ((913,881),(26,14)),
  ((719,570),(25,18)),
  ((419,516),(27,13)),
  ((748,116),(15,13)),
  ((701,655),(27,23)),
  ((673,272),(21,27)),
  ((273,693),(17,13)),
  ((0,98),(18,17)),
  ((810,842),(12,14)),
  ((6,119),(26,15)),
  ((891,587),(12,11)),
  ((947,19),(10,26)),
  ((367,591),(15,16)),
  ((210,779),(28,26)),
  ((337,47),(18,21)),
  ((248,933),(29,18)),
  ((467,819),(13,19)),
  ((31,412),(10,17)),
  ((245,609),(18,17)),
  ((477,553),(26,11)),
  ((501,211),(13,23)),
  ((256,262),(10,23)),
  ((974,702),(17,11)),
  ((237,21),(16,13)),
  ((797,86),(20,26)),
  ((754,398),(12,26)),
  ((615,527),(10,22)),
  ((343,24),(26,16)),
  ((348,535),(26,10)),
  ((516,728),(15,14)),
  ((528,100),(17,15)),
  ((922,69),(12,22)),
  ((410,118),(13,23)),
  ((497,161),(29,28)),
  ((100,951),(10,26)),
  ((170,235),(15,14)),
  ((127,956),(24,25)),
  ((864,829),(14,17)),
  ((236,425),(18,12)),
  ((266,122),(14,11)),
  ((505,526),(23,14)),
  ((670,831),(26,13)),
  ((772,171),(15,28)),
  ((437,131),(18,10)),
  ((496,863),(20,24)),
  ((168,408),(15,14)),
  ((526,425),(24,22)),
  ((890,904),(23,10)),
  ((460,24),(12,19)),
  ((497,81),(26,25)),
  ((694,507),(4,17)),
  ((170,594),(22,21)),
  ((415,625),(19,12)),
  ((638,804),(26,23)),
  ((113,637),(13,14)),
  ((158,441),(25,21)),
  ((635,11),(10,24)),
  ((239,375),(26,22)),
  ((784,166),(18,11)),
  ((649,762),(23,21)),
  ((235,831),(13,23)),
  ((452,879),(12,27)),
  ((105,629),(15,12)),
  ((133,153),(19,18)),
  ((869,103),(28,12)),
  ((370,670),(20,29)),
  ((610,108),(27,29)),
  ((467,158),(20,10)),
  ((866,194),(11,24)),
  ((319,250),(16,10)),
  ((543,141),(22,13)),
  ((25,742),(16,26)),
  ((781,716),(9,5)),
  ((885,568),(10,27)),
  ((297,174),(19,13)),
  ((696,325),(21,16)),
  ((127,715),(24,15)),
  ((247,374),(24,28)),
  ((934,561),(18,11)),
  ((523,827),(12,23)),
  ((938,41),(26,25)),
  ((841,960),(28,18)),
  ((959,837),(14,15)),
  ((456,614),(29,10)),
  ((184,764),(22,24)),
  ((667,804),(25,24)),
  ((22,92),(29,20)),
  ((27,604),(10,21)),
  ((970,594),(28,23)),
  ((469,647),(18,11)),
  ((469,169),(13,18)),
  ((904,504),(22,14)),
  ((346,757),(12,13)),
  ((455,578),(26,16)),
  ((271,319),(13,10)),
  ((90,969),(16,15)),
  ((938,187),(15,25)),
  ((86,642),(15,16)),
  ((531,887),(23,26)),
  ((525,86),(21,24)),
  ((922,939),(14,23)),
  ((473,143),(21,27)),
  ((308,628),(29,11)),
  ((508,788),(25,18)),
  ((678,368),(25,10)),
  ((445,456),(13,12)),
  ((530,244),(24,23)),
  ((39,194),(28,27)),
  ((282,165),(23,21)),
  ((297,98),(25,17)),
  ((415,636),(29,10)),
  ((611,577),(16,22)),
  ((628,480),(25,20)),
  ((338,575),(18,28)),
  ((963,672),(23,23)),
  ((912,10),(23,18)),
  ((392,763),(26,11)),
  ((41,279),(28,22)),
  ((524,836),(11,23)),
  ((247,413),(26,28)),
  ((209,438),(21,29)),
  ((172,580),(26,20)),
  ((781,900),(24,29)),
  ((776,720),(16,24)),
  ((196,408),(15,10)),
  ((490,888),(17,21)),
  ((813,903),(25,15)),
  ((18,888),(22,11)),
  ((243,420),(10,24)),
  ((939,252),(19,13)),
  ((509,236),(20,15)),
  ((202,813),(12,28)),
  ((908,705),(10,20)),
  ((275,313),(10,20)),
  ((373,808),(16,12)),
  ((54,739),(26,12)),
  ((731,441),(20,13)),
  ((271,710),(29,28)),
  ((596,307),(23,14)),
  ((226,612),(25,18)),
  ((85,99),(15,22)),
  ((326,252),(19,18)),
  ((874,207),(22,10)),
  ((260,117),(24,14)),
  ((467,157),(29,29)),
  ((523,632),(27,25)),
  ((735,718),(14,20)),
  ((880,435),(12,24)),
  ((471,929),(18,15)),
  ((767,253),(23,25)),
  ((9,111),(27,12)),
  ((928,235),(15,27)),
  ((118,9),(22,19)),
  ((683,669),(13,27)),
  ((981,348),(14,27)),
  ((743,809),(28,27)),
  ((261,426),(13,14)),
  ((244,182),(27,15)),
  ((868,906),(3,10)),
  ((425,424),(12,22)),
  ((501,68),(11,19)),
  ((915,183),(21,14)),
  ((889,837),(15,22)),
  ((751,582),(16,20)),
  ((641,381),(26,25)),
  ((367,185),(22,12)),
  ((833,447),(26,21)),
  ((108,32),(25,24))]
