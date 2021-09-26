#!/usr/bin/perl -w
########################################################################################################################################################################################
##    For a detailed description of this evaluation metric and source code, please read:                                                                                           #####
##    This code is to implement the Machine Translation Evaluation metric hLEPOR                                                                                                   #####
##    hLEPOR evaluation metric is proposed by Aaron Li-Feng Han, Derek F. Wong, Lidia S. Chao, Liangye He and Yi Lu in University of Macau                                         #####
##    This perl code is  written by Aaron Li-Feng Han in university of macau, 2013.04                                                                                              #####
##    All Copyright (c) preserved by the authors. Corresponding author: Aaron Li-Feng Han < hanlifengaaron@gmail.com >                                                             #####
##    Please cite paper below if you use the metric or source code in your research work                                                                                           #####
##    "Unsupervised Quality Estimation Model for English to German Translation and Its Application in Extensive Supervised Evaluation". Aaron Li-Feng Han, Derek F. Wong,          #####
##    Lidia S. Chao, Liangye He and Yi Lu. The Scientific World Journal, Issue: Recent Advances in Information Technology. Hindawi Publishing Corporation.                         #####
##    Source code website: https://github.com/aaronlifenghan/aaron-project-lepor                                                                                                   #####
##    Online paper: http://www.hindawi.com/journals/tswj/                                                                                                                          #####
########################################################################################################################################################################################
##    How to use this Perl code and how to assign the weights of sub-factors, e.g. Precision, Recall, Length penalty, Position difference penalty, et.                             #####
##    1. Your system output translation documents and the reference translation document should contain the plain text only, each line containing one sentence.                    #####
##    2. Put you system output translation documents under the address in Line 23, 53, 55 of this Perl code.                                                                       #####
##    3. Put you reference translation document under the address in Line 27 of this Perl code.                                                                                    #####
##    4. Tune the alpha:beta(Recall:Precision) weights in Line 176; Tune the HPR:ELP:NPP weights in Line 369-371 of this Perl code.                                                #####
##    5. The document containing evaluation score of hLEPOR will be shown under the address in Line 57 of this Perl code.                                                          #####
##                                                                                                                                                                                 #####
########################################################################################################################################################################################
# /Users/lifenghan/Desktop/lepor/2sh170630
$langpair='2sh170630_hLEPOR4DE-EN';
# /Users/lifenghan/Downloads/$langpair/sys 

opendir (DIR, "/Users/lifenghan/Downloads/$langpair/sys") || die "can not open output file!"; ## put the address of system output translation documents here
@filename=readdir(DIR);
closedir (DIR);

open REF,"<:encoding(utf8)","/Users/lifenghan/Downloads/$langpair/ref/Edit-Dis_REF-1.txt" or die "can't open reference\n"; ## put the address of reference translation document here

		$j=0;
		$str1="";
		@arry_r1=();
		@arry_ref_length= ();
		@arrytwo_ref_translation=();
		$num_of_ref_sentence=0;
		while($str1=<REF>)               #### put the reference translation into a two dimension array @arrytwo_ref_translation
			{
				chomp($str1);
				$str1= lc ($str1);   ### when doing the matching, lower and upper case is concidered the same
				@arry_r1= split(/\s+/,$str1);
				$arry_ref_length[$j]=scalar(@arry_r1);             #### @arry_ref_length store the lengths of every sentence(line) of the reference translation.
				$j++;
				push @arrytwo_ref_translation, [@arry_r1];
				@arry_r1= ();
			}
		$num_of_ref_sentence=$j;
close REF;


## go through all the files in the route
foreach $file (@filename)
	{
		if(!(-d "/Users/lifenghan/Downloads/$langpair/sys/$file"))  ## put the address of system output translation documents here
			{
				open (TEST,"<:encoding(utf8)","/Users/lifenghan/Downloads/$langpair/sys/$file") || die "can not open file: $!";  ## put the address of system output translation documents here

				open (RESULT,">/Users/lifenghan/Downloads/$langpair/score/Score_$file.txt") || die "$!"; ## put the address of evaluation results documents here
				$i=0;
				$str0="";
				@arry_1= ();
				@arry_sys_length= ();
				@arrytwo_sys_translation= ();
				$sentence_num=0;
				while($str0=<TEST>)                       #### put the system translation into a two dimension array @arrytwo_sys_translation
					{
						chomp($str0);
						$str0= lc ($str0);   ### both reference and system output translation is turned into lowwer case
						@arry_1= split(/\s+/,$str0);
						$arry_sys_length[$i]=scalar(@arry_1);       #### @arry_sys_length store the lengths of every sentence(line) of the system translation.
						$i++;
						push @arrytwo_sys_translation, [@arry_1];
						@arry_1= ();
					}
				$sentence_num=$i;
				close TEST;

				@LP= ();
				for($k=0;$k<$sentence_num;$k++)               ##### @LP store the longth penalty coefficient of every LP[i]
					{
						if($arry_sys_length[$k]>0 && $arry_ref_length[$k]>0)
							{
								if($arry_sys_length[$k]>$arry_ref_length[$k])
										{
											if($arry_ref_length[$k]>0)
												{
													$LP[$k]=exp(1-($arry_sys_length[$k]/$arry_ref_length[$k]));
												}
											else
												{
													$LP[$k]=0;
												}


										}
								else
										{
											if($arry_sys_length[$k]==0)
												{
													$LP[$k]=0;
												}
											elsif($arry_sys_length[$k]>0)
												{
													$LP[$k]=exp(1-($arry_ref_length[$k]/$arry_sys_length[$k]));
												}
											#$LP[$k]=exp(1-($arry_ref_length[$k]/$arry_sys_length[$k]));
										}
							}
					}
				$Mean_LP= 0;
				for($k=0;$k<$sentence_num;$k++)
					{
						$Mean_LP=$Mean_LP+$LP[$k];
					}
				$Mean_LP= $Mean_LP/$sentence_num;
				##$Mean_LP= $Mean_LP/2051;

				@common_num=();
				for($i=0;$i<$sentence_num;$i++)        #####  store the common number between sys and ref into @common_num
					{
						$m=0;@record_position=();    ####everytime,select one sentence from the sys, clear the record array
						for($j=0;$j<$arry_sys_length[$i];$j++)
							{
								for($k=0;$k<$arry_ref_length[$i];$k++)
									{
										if($arrytwo_sys_translation[$i][$j] eq $arrytwo_ref_translation[$i][$k])
											{
												#if(!( any(@record_position) eq $k )) ####every word in the reference use not more than once to matched
												if(!( grep(/^$k/,@record_position) )) ####every word in the reference use not more than once to matched
													{
														$common_num[$i]++;
														$record_position[$m]=$k; $m++; ####record the position in the reference already matched
														last;         #### every word of the sys only match the reference once
													}

											}
									}
							}
					}

				@P= ();
				@R= ();
				for($i=0;$i<$sentence_num;$i++)            #####calculate the precision and recall into @P and @R
					{
						if(($common_num[$i])!= 0)
							{
								$P[$i]=$common_num[$i]/$arry_sys_length[$i];
								$R[$i]=$common_num[$i]/$arry_ref_length[$i];
							}
						else
							{
								$P[$i]=0;
								$R[$i]=0;
							}
					}

				$Mean_precision=0;
				$Mean_recall=0;
				for($i=0;$i<$sentence_num;$i++)
					{
						$Mean_precision= $Mean_precision+$P[$i];
						$Mean_recall= $Mean_recall+$R[$i];
					}
				$Mean_precision= $Mean_precision/$sentence_num;
				$Mean_recall= $Mean_recall/$sentence_num;

				$a=9;   #####$a is a varerble to be changed according to different language envirenment #### H(P,9R)
				#$a=1/9;   #####$a is a varerble to be changed according to different language envirenment#### H(9P,R)
				#$a=1;   #####$a is a varerble to be changed according to different language envirenment#### H(P,R)
				#$a=6/4;   #####$a is a varerble to be changed according to different language envirenment#### H(4P,6R)


				@Harmonic_mean_PR=();
				for($i=0;$i<$sentence_num;$i++)    ####calculate the harmonic mean of P and a*R
					{
						if($P[$i]!=0 || $R[$i]!=0)
							{
								$Harmonic_mean_PR[$i]=((1+$a)*$P[$i]*$R[$i])/($R[$i]+$a*$P[$i]);
							}
						else
							{
								$Harmonic_mean_PR[$i]=0;
							}
					}

				$Mean_HarmonicMean=0;
				for($i=0;$i<$sentence_num;$i++)
					{
						$Mean_HarmonicMean= $Mean_HarmonicMean+ $Harmonic_mean_PR[$i];
					}
				$Mean_HarmonicMean= $Mean_HarmonicMean/$sentence_num;


				@pos_dif=();
				@pos_dif_record= ();
				@pos_dif_record_flag= ();
				@pos_dif_record_ref_flag= ();
				for($i=0;$i<$sentence_num;$i++)        #####  store the position-different value between sys and ref into @pos_dif
					{
						for($j=0;$j<$arry_sys_length[$i];$j++)
							{
								$pos_dif_record_flag[$i][$j]= "none_match"; ##firstly make every system translation word's flag equal to none
								#$store_ref_pos=-1000;
								for($k=0;$k<$arry_ref_length[$i];$k++)
									{
										$pos_dif_record_ref_flag[$i][$k]= "un_confirmed";
										if($arrytwo_sys_translation[$i][$j] eq $arrytwo_ref_translation[$i][$k])
											{
												$pos_dif_record_flag[$i][$j]= "exist_match"; ##if there is match,then change the flag as exist_match
												$flag_confirm=0;
												if ($j eq 0)  ###this word is in the begining of sys-output sentence,then check its next word match-condition
													{
														$condition=0;
														for($count_num_sys=1;$count_num_sys<=2;$count_num_sys++) ##check the following two words' match
															{
																for($count_num_ref=1;$count_num_ref<=2;$count_num_ref++)##to match the reference following two words
																	{
																		if($arrytwo_sys_translation[$i][$j+$count_num_sys] eq $arrytwo_ref_translation[$i][$k+$count_num_ref])
																			{
																				$pos_dif_record_flag[$i][$j]= "confirm_match"; ##if the context is also matched then confirm this match
																				$pos_dif_record_ref_flag[$i][$k]= "is_confirmed";
																				$pos_dif_record[$i][$j]= $k; ####record the matched position
																				$flag_confirm=1;
																				$condition=1;
																				last;
																			}

																	}
																if($condition==1) ##check whether it is matched in last loop
																	{
																		last;
																	}
															}
													}
												elsif (($j eq ($arry_sys_length[$i]-1))|| ($j eq ($arry_sys_length[$i]-2))) ##this word is '.' or a word in the end of the sys-output sentence
													{
														$condition=0;
														for($count_num_sys=1;$count_num_sys<=2;$count_num_sys++) ##check the before two words' match
															{
																for($count_num_ref=1;$count_num_ref<=2;$count_num_ref++)##to match the reference before two words
																	{
																		if($arrytwo_sys_translation[$i][$j-$count_num_sys] eq $arrytwo_ref_translation[$i][$k-$count_num_ref])
																			{
																				$pos_dif_record_flag[$i][$j]= "confirm_match"; ##if the context is also matched then confirm this match
																				$pos_dif_record_ref_flag[$i][$k]= "is_confirmed";
																				$pos_dif_record[$i][$j]= $k;###record the matched position
																				$flag_confirm=1;
																				$condition=1;
																				last;
																			}

																	}
																if($condition==1) ##check whether it is matched in last loop
																	{
																		last;
																	}
															}
													}
												else ### this word is in the middle of sys-output sentence,not beginnin and not end
													{
														$condition=0;
														for($count_num_sys=-2;$count_num_sys<2;$count_num_sys++) ##check the former and back two words' match
															{
																for($count_num_ref=-2;$count_num_ref<=2;$count_num_ref++)##to match the former and back two words' match
																	{
																		if($arrytwo_sys_translation[$i][$j+$count_num_sys] eq $arrytwo_ref_translation[$i][$k+$count_num_ref])
																			{
																				$pos_dif_record_flag[$i][$j]= "confirm_match"; ##if the context is also matched then confirm this match
																				$pos_dif_record_ref_flag[$i][$k]= "is_confirmed";
																				$pos_dif_record[$i][$j]= $k;###record the matched position
																				$flag_confirm=1;
																				$condition=1;
																				last;
																			}

																	}
																if($condition==1) ##check whether it is matched in last loop
																	{
																		last;
																	}
															}
													}

												if($flag_confirm==1)##if confirm_match has been down,then the following words in ref neednot go through to match again
													{
														last;
													}
											}
									}
							}
						for($j=0;$j<$arry_sys_length[$i];$j++)###after all the confirm_match has done,then deal with the exist but not confirmed match,using nearest-match
							{
								$store_ref_unconfirm_pos=-10000;
								for($k=0;$k<$arry_ref_length[$i];$k++)
									{
										if($pos_dif_record_flag[$i][$j] eq "exist_match") #deal with the existed but not confirmed word in sys-output
											{
												if($arrytwo_sys_translation[$i][$j] eq $arrytwo_ref_translation[$i][$k])
													{
														#if(!( grep(/^$k/,@record_position) )) ####every word in the reference use not more than once to matched
														#if(!(grep(/^$k/,@)))##check whether position k has been confirmed
														if($pos_dif_record_ref_flag[$i][$k] eq "un_confirmed")##this ref-word has not been confirmed
															{
																if( abs($k-$j) < abs($store_ref_unconfirm_pos-$j)) ##select the nearest word from ref to match sys-word
																	{
																		$store_ref_unconfirm_pos=$k;
																	}
															}
													}
											}
									}
								if($store_ref_unconfirm_pos>=0)
									{
										$pos_dif_record[$i][$j]= $store_ref_unconfirm_pos;###record the nearest matched position
									}
							}
						for($j=0;$j<$arry_sys_length[$i];$j++)##after all the matched postion recored,then calculate each word's Pos-Diff value
							{
								if($pos_dif_record_flag[$i][$j] eq "none_match")
									{
										##$pos_dif[$i][$j]= abs(($store_ref_pos+1)/$arry_ref_length[$i]-($j+1)/$arry_sys_length[$i]);
										$pos_dif[$i][$j]=0;
									}
								else ##calculate the matched word's PosDiff
									{
										$pos_dif[$i][$j]= abs((($j+1)/$arry_sys_length[$i])-(($pos_dif_record[$i][$j]+1)/$arry_ref_length[$i]));
									}
							}
					}
				@Pos_dif_sum= ();
				@Pos_dif_value= ();
				for($i=0;$i<$sentence_num;$i++)
					{
						for($j=0;$j<$arry_sys_length[$i];$j++)    #### sum the Pos_dif_distance of one sentence,then divided by the lenth of the sentence
							{
								$Pos_dif_sum[$i]= $Pos_dif_sum[$i] + $pos_dif[$i][$j];
							}
						if($arry_sys_length[$i]>0)
							{
								$Pos_dif_sum[$i]=$Pos_dif_sum[$i]/$arry_sys_length[$i];
								$Pos_dif_value[$i]= exp(-$Pos_dif_sum[$i]);   #### calculate the every sentence's value of Pos_dif_value by taking the exp.
							}
						#$Pos_dif_sum[$i]=$Pos_dif_sum[$i]/$arry_sys_length[$i];
						#$Pos_dif_value[$i]= exp(-$Pos_dif_sum[$i]);   #### calculate the every sentence's value of Pos_dif_value by taking the exp.
					}
				$Mean_pos_dif_value=0;
				for($i=0;$i<$sentence_num;$i++)
					{
						$Mean_pos_dif_value= $Mean_pos_dif_value+$Pos_dif_value[$i];
					}
				$Mean_pos_dif_value= $Mean_pos_dif_value/$sentence_num;


				@HLEPOR_single_sentence=();  ###HLEPOR means a new version of MT evaluation metric LEPOR calculated by the harmonic mean of its parameters (not just multiply them)
				$HLEPOR=0;
				$weight_PR=3;   ## wight of HPR (harmonic mean of precision and recall)
				$weight_LP=2;  ## wight of ELP (enhanced length penalty)
				$weight_Pos=1;  ## wight of NPP (n-gram position difference penalty)


				for($i=0;$i<$sentence_num;$i++)    #### calculate the final evaluation value of HLEPOR
					{
						if($LP[$i]>0 && $Pos_dif_value[$i]>0 && $Harmonic_mean_PR[$i]>0)
							{
								$HLEPOR_single_sentence[$i]= ($weight_LP+$weight_Pos+$weight_PR)/($weight_LP/$LP[$i]+$weight_Pos/$Pos_dif_value[$i]+$weight_PR/$Harmonic_mean_PR[$i]);
							}
						else
							{
								$HLEPOR_single_sentence[$i]=0;
							}

						$HLEPOR= $HLEPOR+$HLEPOR_single_sentence[$i];
					}
				$HLEPOR= $HLEPOR/$sentence_num;
				print "LEPOR-1\t$langpair\tnewstest2019\t$file\t$HLEPOR\tNo\tpoethan.github.com\n";


				#### another way to calculate the mean HLEPOR of system_output(using all sentences' mean parameter-value)
				$HLEPOR_anotherway=0;
				if($Mean_LP>0 && $Mean_pos_dif_value>0 && $Mean_HarmonicMean>0)
					{
						$HLEPOR_anotherway= ($weight_LP+$weight_Pos+$weight_PR)/($weight_LP/$Mean_LP+$weight_Pos/$Mean_pos_dif_value+$weight_PR/$Mean_HarmonicMean);
					}
				else
					{
						$HLEPOR_anotherway=0;
					}


				#close TEST;
				#close REF;
				close RESULT;



			}
	}
