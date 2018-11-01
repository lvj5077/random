#! /bin/bash

for j in {1..5}
do
	echo $"ate tum_vio_result_test1/room"$j"_512_16/okvis"
	for i in {1..5}
	do
	   python /Users/lingqiujin/Desktop/trajectAnalysis_07_02_2018/evaluate_ate.py /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/data.csv.txt /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/okvis/result_${i}.log
	done

	# echo $"rpe tum_vio_result_test1/room"$j"_512_16/okvis"
	# for i in {1..5}
	# do
	#    python /Users/lingqiujin/Desktop/trajectAnalysis_07_02_2018/evaluate_rpe.py /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/data.csv.txt /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/okvis/result_${i}.log
	# done

#-----------------------------------------------------------------
	echo $"ate tum_vio_result_test1/room"$j"_512_16/rovio"
	for i in {1..5}
	do
	   python /Users/lingqiujin/Desktop/trajectAnalysis_07_02_2018/evaluate_ate.py /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/data.csv.txt /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/rovio/result_${i}.log
	done

	# echo $"rpe tum_vio_result_test1/room"$j"_512_16/rovio"
	# for i in {1..5}
	# do
	#    python /Users/lingqiujin/Desktop/trajectAnalysis_07_02_2018/evaluate_rpe.py /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/data.csv.txt /Users/lingqiujin/Desktop/tum_vio_result_test1/room${j}_512_16/rovio/result_${i}.log
	# done



done







