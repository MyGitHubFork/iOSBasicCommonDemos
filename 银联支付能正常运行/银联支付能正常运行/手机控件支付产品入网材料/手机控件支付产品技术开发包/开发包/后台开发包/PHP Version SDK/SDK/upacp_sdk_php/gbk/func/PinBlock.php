<?php
	/**
	 * Author: gu_yongkang 
	 * data: 20110510
	 * 密码转PIN 
	 * Enter description here ...
	 * @param $spin
	 */
	function  Pin2PinBlock( &$sPin )
	{
	//	$sPin = "123456";
		$iTemp = 1;
		$sPinLen = strlen($sPin);
		$sBuf = array();
		//密码域大于10位
		$sBuf[0]=intval($sPinLen, 10);
	
		if($sPinLen % 2 ==0)
		{
			for ($i=0; $i<$sPinLen;)
			{
				$tBuf = substr($sPin, $i, 2);
				$sBuf[$iTemp] = intval($tBuf, 16);
				unset($tBuf);
				if ($i == ($sPinLen - 2))
				{
					if ($iTemp < 7)
					{
						$t = 0;
						for ($t=($iTemp+1); $t<8; $t++)
						{
							$sBuf[$t] = 0xff;
						}
					}
				}
				$iTemp++;
				$i = $i + 2;	//linshi
			}
		}
		else
		{
			for ($i=0; $i<$sPinLen;)
			{
				if ($i ==($sPinLen-1))
				{
					$mBuf = substr($sPin, $i, 1) . "f";
					$sBuf[$iTemp] = intval($mBuf, 16);
					unset($mBuf);
					if (($iTemp)<7)
					{
						$t = 0;
						for ($t=($iTemp+1); $t<8; $t++)
						{
							$sBuf[$t] = 0xff;
						}
					}
				}
				else 
				{
					$tBuf = substr($sPin, $i, 2);
					$sBuf[$iTemp] = intval($tBuf, 16);
					unset($tBuf);
				}
				$iTemp++;
				$i = $i + 2;
			}
		}
		return $sBuf;
	}
	/**
	 * Author: gu_yongkang
	 * data: 20110510
	 * Enter description here ...
	 * @param $sPan
	 */
	function FormatPan(&$sPan)
	{
		$iPanLen = strlen($sPan);
		$iTemp = $iPanLen - 13;
		$sBuf = array();
		$sBuf[0] = 0x00;
		$sBuf[1] = 0x00;
		for ($i=2; $i<8; $i++)
		{
			$tBuf = substr($sPan, $iTemp, 2);
			$sBuf[$i] = intval($tBuf, 16);
			$iTemp = $iTemp + 2;		
		}
		return $sBuf;
	}
	
	function Pin2PinBlockWithCardNO(&$sPin, &$sCardNO)
	{
		global $log;
		$sPinBuf = Pin2PinBlock($sPin);
		$iCardLen = strlen($sCardNO);
//		$log->LogInfo("CardNO length : " . $iCardLen);
		if ($iCardLen <= 10)
		{
			return (1);
		}
		elseif ($iCardLen==11){
			$sCardNO = "00" . $sCardNO;
		}
		elseif ($iCardLen==12){
			$sCardNO = "0" . $sCardNO;
		}
		$sPanBuf = FormatPan($sCardNO);
		$sBuf = array();
		
		for ($i=0; $i<8; $i++)
		{
//			$sBuf[$i] = $sPinBuf[$i] ^ $sPanBuf[$i];	//十进制
//			$sBuf[$i] = vsprintf("%02X", ($sPinBuf[$i] ^ $sPanBuf[$i]));
			$sBuf[$i] = vsprintf("%c", ($sPinBuf[$i] ^ $sPanBuf[$i]));
		}
		unset($sPinBuf);
		unset($sPanBuf);
//		return $sBuf;
		$sOutput = implode("", $sBuf);	//数组转换为字符串
		return $sOutput;
	}

?>