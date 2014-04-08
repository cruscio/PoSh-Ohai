﻿$provides = "memory"

function Collect-Data {
    $meminfo = [ordered]@{}
	
	try
	{
		$memory = Get-WmiObject Win32_PerfRawData_PerfOS_Memory
		
		$meminfo["AvailableMBytes"] = $memory.AvailableMBytes
		$meminfo["CommittedMBytes"] = [int]($memory.CommittedBytes / (1024*1024))
		$meminfo["SystemCacheMBytes"] = [int]($memory.CacheBytes / (1024*1024))
		$meminfo["NonPagedPoolMBytes"] = [int]($memory.PoolNonpagedBytes / (1024*1024))
		$meminfo["PagedPoolMBytes"] = [int]($memory.PoolPagedBytes / (1024*1024))
	}
	catch
	{
		$meminfo["Error"] = $_.Exception.ToString()
	}
	
    @{ "memory" = $meminfo}
}