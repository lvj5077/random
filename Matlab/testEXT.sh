#! /bin/bash

path 
for j in {"room1_512_16","room2_512_16"}
do
	echo $"vins-mono_ext"
	for i in {1..5}
	do
	   python /Users/lingqiujin/Desktop/trajectAnalysis_07_02_2018/CSV_convert_for_GT.py /Users/lingqiujin/Desktop/tum_vio_result3/${j}/vins-mono_ext/result_${i}.log

	   python /Users/lingqiujin/Desktop/trajectAnalysis_07_02_2018/evaluate_ate.py /Users/lingqiujin/Desktop/tum_vio_result3/${j}/data.csv.txt /Users/lingqiujin/Desktop/tum_vio_result3/${j}/vins-mono_ext/result_${i}.log.txt
	done


done

echo $"end"
python /Users/lingqiujin/avg.py
