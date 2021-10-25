-------------------------------------------------------------------------------
--
-- Title       : des
-- Design      : Amba1
-- Author      : Zahra
-- Company     : A
--
-------------------------------------------------------------------------------
--
-- File        : testone.vhd
-- Generated   : Sat Jan 14 13:51:50 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {des} architecture {behav}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ts is
	
end ts;

--}} End of automatically maintained section

architecture behav of ts is   
signal 	clk , rst ,BUSREQ1 , BUSREQ2 : std_logic  ;
signal grant1 , grant2 : std_logic ;
component MasterI 
	port (    
		HGrant1 :  in std_logic ; --coming from arbiter for bus req.
		HREADY  :  in std_logic ;
		HRESP   :  in std_logic_vector(1 downto 0);
		HRESETn :  in std_logic ;
		HCLK    :  in std_logic ;
		HRDATA  :  in std_logic_vector(31 downto 0);   
		---
		HadresA  :  in std_logic_vector(31 downto 0);    --coming from outside
		HDATAA   :  inout std_logic_vector(31 downto 0); --coming from outside
		HWRITA   :  in std_logic ;                       --coming from outside 
		--
		HBUSREQ1 :  out std_logic ;
		HADDR    :    out std_logic_vector(31 downto 0) ; -- adres
        HWRIT    :    out std_logic ; -- slave ????? ??
		HBURST   :    in std_logic ;
		HWDATA   :    out std_logic_vector(31 downto 0);
		HSIZE    :    out std_logic ); 
end component;
---------------------------------------------------------------------------

 component MasterII 
	port (    
		HGrant2 :  in std_logic ; --coming from arbiter for bus req.
		HREADY  :  in std_logic ;
		HRESP   :  in std_logic_vector(1 downto 0);
		HRESETn :  in std_logic ;
		HCLK    :  in std_logic ;
		HRDATA  :  in std_logic_vector(31 downto 0);   
		---
		HadresA  :  in std_logic_vector(31 downto 0);    --coming from outside
		HDATAA   :  inout std_logic_vector(31 downto 0); --coming from outside
		HWRITA   :  in std_logic ;                       --coming from outside 
		--
		HBUSREQ2 :  out std_logic ;
		HADDR    :    out std_logic_vector(31 downto 0) ; -- adres
        HWRIT    :    out std_logic ; -- slave ????? ??
		HBURST   :    in std_logic ;
		HWDATA   :    out std_logic_vector(31 downto 0);
		--HLOCKx :    out std_logic;LOCK NO NEED
		--HTRANS :    out std_logic_vector(1 downto 0);
		HSIZE  :    out std_logic );
		
end component ;
-------------------------------------------------------------------------

component slaveM 
		generic (Addr_width : integer := 8;
		         DATA_width : integer := 32);
		 port (
		            HSEL2   : in std_logic;
					HADRRs  : in std_logic_vector(Addr_width-1 downto 0);
					HWRITs  : in std_logic;
					HBURSTs : in std_logic;	
			      --HTRANSs : in std_logic_vector(1 downto 0);
					HWDATAs : in std_logic_vector(DATA_width-1 downto 0);
					HRESETns :  in std_logic ;
		            HCLKs   :  in std_logic ;
					HREADYs : out std_logic  ;
					HRESPs  : out std_logic  ;
					HRDATAs : out std_logic_vector(DATA_width-1 downto 0)
					);
end component; 
-------------------------------------------------------------------------------------

component slaveII is 
		generic (Addr_width : integer := 8;
		         DATA_width : integer := 32);
		 port (
		            HSEL2   : in std_logic;
					HADRRs  : in std_logic_vector(Addr_width-1 downto 0);
					HWRITs  : in std_logic;
					HBURSTs : in std_logic;	
			      --HTRANSs : in std_logic_vector(1 downto 0);
					HWDATAs : in std_logic_vector(DATA_width-1 downto 0);
					HRESETns :  in std_logic ;
		            HCLKs   :  in std_logic ;
					HREADYs : out std_logic  ;
					HRESPs  : out std_logic  ;
					HRDATAs : out std_logic_vector(DATA_width-1 downto 0)
					);
end component;	   
-----------------------------------------------------------------------------------

component arbit 
	port 
  ( HBUSREQ1 :  in std_logic ;
	HBUSREQ2 :  in std_logic ;
	Hadres : in std_logic_vector(31 downto 0);
	--Htrans : in std_logic_vector(1 downto 0);
	Hburst : in std_logic ;	
	Hready : in std_logic ;
	Hrstn : in std_logic ;
	Hclk  : in std_logic ;	
	----
	HGrant1 :  out std_logic ;
	HGrant2 :  out std_logic ;
	Hmaster :  out std_logic ;
	HadresO :  out std_logic_vector(31 downto 0)
	);
		
end component; 
 -------------------------------------------------------------
component decoder
	port (
	Haddr : in std_logic_vector(31 downto 0);
	Hselx : out std_logic );
end component;


begin
	process	
	begin 
		--BUSREQ1 <=HBUSREQ1 ;		  --??
		--BUSREQ2 <=HBUSREQ2 ;
		--a0: MasterI port map (
		BUSREQ1	<='1' ;	
		wait for 10 ns;
		HBUSREQ1  <= '0';
		HBUSREQ2   <='1';
		wait for 15 ns;
		BUSREQ1<='1';
		BUSREQ2<='1';
		wait   ;
	end process;
end behav;
