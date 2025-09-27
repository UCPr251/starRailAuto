/************************************************************************
 * @description 崩坏·星穹铁道刷本自动点击再来一次、使用燃料脚本
 * @author UCPr
 * @date 2025/09/27
 * @version 1.0.0
 ***********************************************************************/

#Include <FindText>
#Include Admin.ahk

global SR := "ahk_exe StarRail.exe"
global ing := false
global times := -1
global fuel := 0
global runtimes := 0
global CP := 0

panel() {
  global CP
  if (CP) {
    destroyGui()
    return
  }
  CP := Gui('AlwaysOnTop -MinimizeBox', '再来一次')
  CP.OnEvent('Close', destroyGui)
  CP.OnEvent('Escape', destroyGui)
  CP.SetFont('s9', '微软雅黑')
  CP.MarginX := 15
  CP.SetFont('s13')
  CP.AddText('X20', '已刷取次数：' runtimes)
  CP.AddText('X20', '再来一次：')
  CP.AddEdit('X+10 w48 h25 Limit2 Number').OnEvent('Change', changeTimes)
  CP.AddUpDown('Range-1-99', times).OnEvent('Change', changeTimes)
  CP.AddText('X20', '使用燃料：')
  CP.AddEdit('X+10 w48 h25 Limit2 Number').OnEvent('Change', changeFuel)
  CP.AddUpDown('Range0-99', fuel).OnEvent('Change', changeFuel)
  CP.AddButton('H30 X15 w75', '退出').OnEvent('Click', (*) => ExitApp())
  CP.AddButton('H30 X+10 w75', "重启").OnEvent('Click', (*) => Reload())
  CP.AddButton('H30 X15 Y+8 w160', ing ? '终止检测' : '开始检测').OnEvent('Click', toggleDetection)
  CP.Show()
  static destroyGui(*) {
    global CP
    CP.Destroy()
    CP := 0
  }
  static changeTimes(g, *) {
    global times
    value := g.Value
    if (IsInteger(value)) {
      if (value >= -1 && value <= 99) {
        times := Integer(value)
      } else {
        g.Value := times
      }
    }
  }
  static changeFuel(g, *) {
    global fuel
    value := g.Value
    if (IsInteger(value)) {
      if (value >= 0 && value <= 99) {
        fuel := Integer(value)
      } else {
        g.Value := fuel
      }
    }
  }
  static toggleDetection(g, *) {
    global ing := !ing, runtimes
    key := A_ScreenWidth "x" A_ScreenHeight
    if (ing) {
      if (!WinExist(SR)) {
        MsgBox('请先启动星铁', '提示', 'Icon! 0x40000')
        ing := false
        return
      }
      if (times = 0) {
        MsgBox('请先设置检测次数', '提示', 'Icon! 0x40000')
        ing := false
        return
      }
      runtimes := 0
      WinActivate(SR)
      SetTimer(detecte.%key%, 2000)
      destroyGui()
    } else {
      g.Text := '开始检测'
      if (!detecte.HasKey(key)) {
        MsgBox('当前分辨率不支持', '提示', 'Icon! 0x40000')
        ing := false
        return
      }
      SetTimer(detecte.%key%, 0)
    }
  }
}

global detecte := {
  3840x2160: detecte_3840x2160,
  2880x1800: detecte_2880x1800,
  1920x1080: detecte_1920x1080,
}

panel()

!c:: panel()

detecte_3840x2160() {
  global ing, times, runtimes, fuel
  static 再来一次 := "|<>*128$188.00000000000DU000000000000007U00000000000003s000000000000001w00000000000000y000000000000C00S000DzzzzzzU000DU00000000000DU0DU003zzzzzzs0003s000000000001w03s000zzzzzzy0Tzzzzzw000000000TU1w000DzzzzzzU7zzzzzz0000000003s0T0000003s0001zzzzzzk000000000T07zzzk000y0000Tzzzzzw0000000007k3zzzw000DU000040DU100000000000y0zzzz0003s00003U3s0s0000000000DkTzzzk3zzzzzU01w0y0DU0000000001wDk01w0zzzzzs00TUDU7k0000000000TXs00T0Dzzzzy003w3s3w00000000003lw00DU3zzzzzU00T0y1y00000000000kT3s3k0w0DU3s007sDUz000000000000DUy1w0D03s0y000z3sTU000000000007sDUS03k0y0DU007ky7k03zzzzzzz001w3sDU0w0DU3s000sDUs00zzzzzzzs00S0y7k0Dzzzzy00043s600Dzzzzzzy003UDUw03zzzzzU0zzzzzzz3zzzzzzzU0003s200zzzzzs0Dzzzzzzkzzzzzzzs0A00y000Dzzzzy03zzzzzzw0000000007k0DU003s0y0DU0zzzzzzz0000000001w03w000w0DU3s0000zs000000000000T01z000D03s0y0000Dy000000000000DU0Tk003k0y0DU0007zk000000000003s07y000w0DU3s0003zz000000000000w03zU0Dzzzzzzw001zzs00000000000T00zw03zzzzzzzU01zyz000000000007k0TDU0zzzzzzzs00zjbw00000000003s0Dns0Dzzzzzzy00znszU0000000000y07sT003k000DU00Tsy7y0000000000DU3w7s00w0003s00TsDUzs0000000007k1y0z00D0000y00Tw3s3zU000000001w0zU7w03k000DU0Ty0y0Ty000000000z0zk0zU0w0003s0Ty0DU1zk00000000DUTs07w0D0000y07y03s0Dw000000003sTw00zk3k00zzU0z00y00z000000001yDw007z0w00Dzs0D00DU03U00000000D7y000zkD003zw01003s000000000000kz0003s3k00zy00000y0000000000000D0000Q0w007y00000DU0000000000001U00018"
  static 燃料1 := "|<>*135$146.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Dzs005zkDzzzzk00DzznnzzzXzz0007w1zzzzz00DzzyATzzwzzszk0zUTzzzzs0Ttzzk3zzz7zyDw07w3zzzzztzwTzy0Tzzlzzbv01zUTzzzzzzy7zzk3zzyTztzk0Dw7zzzzzzy1rzy0DzzXzwTs01z0zzzzzzz0Rzzk1zzszz3o00AsDzzzzzy07Tzy0Dzz7z0X0024bzzzzzs01rzzk1zzkzs0U000Tzzzzzy00Rzzy0Dzy7y20000BzzzzzzU07Tzzk1zzUzVk8001zzzzzzs01szzy07zw7s80000Dzzzzzy00T7zzU0zzUQ010003zzzzzzU07szzw07zw001U001jzzzzzs01z4TzU0zzk000000zzzzzzw00Tw7zw07zy000000Szzzzzz007z0TzU0zrs0k0007bzzzzzk01zs3zw07zk400001tzzzzzw00TzkTzU0Tz300000STzzzzz00Dzw1zw03zw00000Dbzzzzzk03zzUDzU0TDk00003tzzzzzw00zzy1zw03vy00000yzzzzzz00DzzkDzU0TTk0000DjzzzzzU03zzy1zw03zw00007vzzzzzs01zzzUDzU0Tzk0001wzzzzzy00Tzzs1zw03zw0000TTzzzzzU07zzw0DzU0TzUE00Drzzzzzs01zzzU1zw03zkM003xzzzzzy00TzzU0DzU0TsC001yTzzzzzU07zzsk0Tw03y7k00zDzzzzzs01zzw601zU0DX000Dnzzzzzy00Tzz0k0Dw01X0007tzzzzzzU07zzk201zU09k001wTzzzzzs01zzs0EUDw01s000zDzzzzzy00Tzy03A1zU0A000TnzzzzzzU07zz00HUDw000007tzzzzzzs01zzk03w1zU0A003wzzzzzzy00Tzs00zUDw00U03zDzzzzzzU07zy00Dy1zU040Nzbzzzzzzw01zz003zUDw00U7Tnzzzzzzz00TzU01zs1zU040Tszzzzzzzk07zs00Ty0Ds000TwTzzzzzzw01zy00DzU3zU00DyDzzzzzzzU0Tz003zy0Tw01bp7zzzzzzzs03zU01zzk3z007xXzzzzzzzy00zk00Tzy0Ds01sNzzzzzzwzU0Dw00Dzzk1zU008zzzzzzz7w01y003zza0Ds008zzzzzzzlz00T001zzts5zU04TzzzzzzwTk03U00zzyD3zw07Dzzzzzzy7z00k00Dzz3sTz00DzzzzzzzVzs00007zzkw7zk07zzzzzzzsDzk0001zzw7AzU07zzzzzzzw3zzk000zzy1ttk01zzzzzzzz0Tzzn00TzzUDbg80DzzzzzzzU7zzzk0Dzzk3zzzc1zzzzzzzk0Tzzs07zzs0Dzzw0Dzzzzzzs03zzw03zzs01zzy01zzzzzzw00Tzy00zzw00Dzz00Dzzzzzy003zz001zy001zz001zzzzzy000Dy0007z0007z0007zzzzy0000z0000z0000z0000Tzzzw00000000000000000000zzzs000000000000000000001zzw000000000000000000000Tzzs00000000000000000000Tzzzk0003s0003s0001w0000zzzzzU003zU003zk001zk001zzzzzy003zy003zz001zz001zzzzzzk01zzk01zzs00zzs00zzzzzzy00zzz00zzz00zzz00Tzzzzzzk0Tzzk0Tzzs0Dzzs0Dzzzzzzy0Dzzy0Dzzz07zzz07zzzzzzzk7zzzk3zzzk3zzzs3zzzzzzzw1zzzw1zzzy0zzzy0zzzzzzzzUzzzzUzzzzkTzzzkTzzzzzzzsTzzzwDzzzwDzzzy7zzzzzzzy7zzzz3zzzz3zzzzVzzzzzzzzlzzzzlzzzzszzzzszzzzs"
  static 燃料2 := "|<>*136$153.zzzzzzzzzz1zzzzzzzzzzzzzzzzzzzzzzzzU1zzzzzzzzzzzzzzzzzzzzzzzw03zzzzzzzzzzzzzzzzzzzzzzw007zzzzzzzzzzzzzzzzzzzzzz7z0TzzzzzzzzzzzzzzzzzzzzzU0D3zzzzzzzzzzzzzzzzzzzzzsk0y7zzzzzzzzzzzzzzzzzzzzy400MzzzzzzzzzzzzzzzzzzzzzU0zU3zzzzzzzzzzzzzzzzzzzzw0Dz0Dzzzzzzzzzzzzzzzzzzzy03zwEzzzzzzzzzzzzzzzznzzzk0zzk7zzzzzzzzzzzzzzzkDzzw0Dzz0TzzzzzzzzzzzzzzsFzzzU3zzw1zzzzzzzzzzzzzzw0Dzy00zzzk7zzzzzzzzzzzzzz1XzzU2Dzzy0Tzzzzzzzzzzzzz0Qzzw0lzzzs3zzzzzzzzzzzzzk0Tzzg6TzzzUDzzzzzzzzzzzzw03zzzlrzzzy0zzzzzzzzzzzzz00TzzzwTzzzt3zzzzzzzzzzzzk13zzzz1zzzzUDzzzzzzzzzzzw0QTzzzsDzzzw0zzzwBzzzzzzz03XzzzjVzzzzm7zzy1rzzzzzzs0z7zzzwTzzzz0Tzzk23zzzzzy07szy1zbzzzzw1zzw087zzzzzk333ykDbzzzzzU7zy01UDzzzzw1kszz1zzzzzzy0zzk0A0zzzzzDsCDzw1zzzzzzt3zw00k3zzzzty1Xzzm7zzzzzzUDz00607zzzzw0sszzUzzzzzzy0zs00E0Dzzzz24C3zwATzzzzzk7y00200zzzxkx3kzy33zzy03z8TU00M03zzz0DUyDzXkBzzk0Dw1w00700Tzzs3yTVzww17zzU0zk7001s01zzz1zzwTz7UMwDw01y0s00T00DzzwTzz7zkw300zU0Dx3007s01zzzzzzzzw3UE03s00zUA00z00Dzzzzrzzz0w600T003yFk0Ds01zzzzxzzzk7lk03s00Dk703z00DzzzzDzzwEyQ00S000zcM0zs00zzzztzzz6DrU07k003w1UDz007zzzzDzzkDzs00y000DkC1zw00zzzzzzTwFzy00DU001y0sTz007zzzzzly0zzk01s0007t33zs00zzzzxsDUDzw00C0000QkAzz007zzzzi3w1zzU03U0001W1rzs00zzzzxVyQDzk00y0000AN3zz007zzzzzy33zy00D00000lcTzs00zzzzzDU0zzU01k0000361zy00Dzzzzs00zzs00Q000008K7zk01zzzzz00zzy007zs0000ncTy0UDzzzzw0TzzU01zzy0002B3zkS1zzzzzk7zzw00DzzzU00MqDw7sDzzzzz3Uzz003zzzy001W0zjzVzzzzzwMDzk00zzyDs00693zzyTzzzzzm3zy00DzzVzU00FcTzznzzzzzz0zzz03zzsDy001C1zzzTzzzzzwDzzw0zzz3zs00Dm7zzzzzzzzzkzzl0DzzkTzU00z8Tzzzzzzzzz3zy83zzw7zy007w1zzzzzzzzzzTy10zvz1zzs00TkDzzzzzzzzzzy0MTw7kTzV003y0zzzzzzzzzz0A37z00Dzk000Tx3zzzzzzzzzk1UNzk03zw0003zsDzzzzzzzzUTk3yM00zz3s00rylzzzzzzzzw7y0TU00DzkzU07zs7zzzzzzzzU8U3k001zyDy01zzcTzzzzzzzy100w000TzlU80Tzx1zzzzzzzzk007U003zwA007zzkDzzzzzzzz000s000s0V00Fzzy0zzzzzzzzs00D00080080njzzt3zzzzzzzz001y0000011yDzzzUDzzzzzzzs00DzU00027ztzzzy1zzzzzzzz001zzzzzzszzDjzzs7zzzzzzzv00DzzzzzzXztzzzzcTzzzzzzyQ01jzzzzzyDzDzzzw1zzzzzzzXU0FzzzzzzsTszzzzkDzzzzzzwS02DzzzzzzkTbzzzz0zzzzzzzXs0lzzzzzzz0szzzzx3zzzzzzwzUCDzzzzzzy03zzzzkDzzzzzzby1Uzzzzzzzz000zzy0zzzzzzwzsQ7zzzzzzzz000Tzs7zzzzzzbzb0zzzzzzzzwQ00TzcTzzzzzyDzk7zzzzzzzzbzk0zy1zzzzzzlzw0zzzzzzzzwzzU1zk7zzzzzy7w07zzzzzzzzXzzw1z0zzzzzzmz00zzzzzzzzyTzzs7w3zzzzzzTk07zzzzzzzznzzzkTkDzzzzzfA00TzzzzzzzyTzzzVy0zzzzzzxU03zzzzzzzznzzzy7s7zzzzzzs00TzzzzzzzyTzzzsTUTzzzzzz003zzzzzzzznzzzzXy1zzzzzzw00TzzzzzzzyTsTzyDk7zzzzzzU01zzzzzzzznz0zzsz0zzzzzzs00DzzzzzzzyTw0zz7w3zzzzzz001zzzzzzzzlzU3zsTkDzzzzzs007zzzzzzzyDwQTz3y0zzzzzz000TzzzzzzzlznnzwTs3zzzzzs000zzzzzzzyDySDzVzUTzzzzz0000DzzzzzzlzllzsDy1zzzzzs0001zzzzzzyDy0Dy0Tl7zzzzz0000zzzzzzztzs0y07z0Tzzzzs000DzzzzzzzDzU001zw3zzzzz0003zzrrzzzszzk00BzkDzzzzw003zzzDTzzz7zz0017y0zzzzzk01zzzwtzzzwzzsTs0Ts3zzzzzU0znzzW3zzzXzz3zU0zUDzzzzzVzwTzy0DzzwTzszs07y1zzzzzzzz3zzw0zzznzz7z00zs7zzzzzzzkTzzU3zzyDzszs03z0zzzzzzzs3jzy0Dzzlzz7q006w7zzzzzzw0Rzzs0zzz7zsNU00lUzzzzzzw03jzzU1zzsTw280009zzzzzzw00Rzzy07zzVzk10000LzzzzzzU03jzzs0TzwDy20E002zzzzzzw00RzzzU1zzkTks2000TzzzzzzU03lzzy03zz1w200001zzzzzzw00Tbzzs0Dzw1000000DzzzzzzU03wTzzU0zzk0060003zzzzzzw00Ts7zw03zz0000000zzzzzzzU03zUTzk0Dzw0000007jzzzzzs00Tz0zz00zzw0E0001wzzzzzz007zs7zw03zw300000Dbzzzzzs00zzkTzk07zss00001wzzzzzz007zz0zz00Tzk00000Dbzzzzzs00zzw3zw01yzU00001wzzzzzz007zzkDzk07rw00000Tjzzzzzs00zzz0zz00zjk00003xzzzzzy00Dzzy3zw03zz00000zTzzzzzk01zzzk7zk0Dzw00007vzzzzzy00Dzzy0Tz00Tzk0000yTzzzzzk01zzzU3zw01zz0000Dnzzzzzy00Dzzw07zk07zkA001yzzzzzzk01zzzk0Tz00Tw3U00Trzzzzzy00DzztU1zw01zUw003wzzzzzzk03zzy601zk03wD000zbzzzzzy00TzzkM07z00DX0007tzzzzzzk03zzy0k0Dw00lU001yDzzzzzy00TzzU200zk01w000Tnzzzzzzk03zzw0AE3z00D0003wzzzzzzy00Tzz00lUDw00kE00zbzzzzzzk01zzs01C0zk00000Dtzzzzzzy00Dzy00Ds3z00A003yDzzzzzzk01zzk00zUDw00E08znzzzzzzy00Dzw00Dy0zk0103Dwzzzzzzzs01zz001zs3z0040vz7zzzzzzz00Dzs00Dz0Dw00E0zlzzzzzzzs01zy003zk0zk000TwTzzzzzzz00Dzk00Tz07z0007z7zzzzzzzw01zw007zw0Tw00FzlzzzzzzzzU0DzU01zzk1zk01z6Tzzzzzzzw00zs00DzzU7z00DtbzzzzzzwzU07y001zzy0Dw00EFzzzzzzzby00zk00TzyM0zk000zzzzzzzwzk07w007zznU3z0037zzzzzzzXy00T000zzwS3Xw01XzzzzzzzsTs01k00DzzVsDzk0Hzzzzzzzz3zU0A001zzwDlzy00TzzzzzzzsTz00000TzzVtbzk07zzzzzzzy1zzU0007zzs7aTU01zzzzzzzzkDzzU001zzz0wQQ00Dzzzzzzzw0zzzn00Dzzk3wzn00zzzzzzzzU7zzzs07zzy0TzzzU7zzzzzzzk0Dzzy00zzz00zzzs0Dzzzzzzw00zzzU0Dzzk03zzy00zzzzzzz003zzs01zzw00DzzU03zzzzzzk00Dzy003zz000zzk00Dzzzzzs000Tz0007zU001zs000Tzzzzy0001zU000Ts0007y0001zzzzw000000000000000000000zzzy0000000000000000000000zzz00000000000000000000007zzy0000000000000000000001zzzy00001U0000M0000600001zzzzz0003zk000zw000Dz0003zzzzzw000zz000Dzk003zw000zzzzzzs00Dzy007zz001zzk00TzzzzzzU07zzs01zzy00TzzU07zzzzzzy01zzzU0Tzzs07zzy01zzzzzzzs0Tzzy07zzzU1zzzs0TzzzzzzzU3zzzs1zzzy0Tzzz07zzzzzzzw0zzzz0Dzzzk3zzzw0zzzzzzzzkDzzzw3zzzz0zzzzkDzzzzzzzz1zzzzUTzzzs7zzzy1zzzzzzzzsTzzzy7zzzzVzzzzsTzzzzzzzz3zzzzkzzzzwDzzzz3zzzzzzzzsTzzzy7zzzzVzzzzsTzzzw"
  static 确认 := "|<>*119$52.000Tzs000007zzs00001zzzw0000Tzzzw0003zzzzs000zzzzzs007zzzzzk00zzzzzz007zzzzzz00zzzzzzw07zzzzzzs0Tzzzzzzk3zzzzzzzUTzzzzzzy1zzzzzzzwDzzzzzzzkzzzzzzDzXzzzzzsTyTzzzzz0ztzzzzzs7zzzzzzz0zzzzzzzs7zzzzzzz0zzzzzzzs7zzzzzzz0zzzzzTzs7zzzzszz0zzzzz1zs7zzzzw3z0zzzzzk7s7zzzzzUD0zzzzzz0M7zzzrzy00zzzzTzw07zzzszzs0zzzzXzzk7zzzyDzzUzzzzkTzz7zzzz1zzyzzzzs3zzzzzzzUDzzzzzzw0TzzzzzzU0zzzzzzw01zzzzzzk03zzzzzw007zzzzzk00Dzzzzy000TzzzzU000Tzzzw0000Tzzz00000DzzU00000Dzs002"
  static end() {
    global ing
    ing := false
    SetTimer(detecte_3840x2160, 0)
  }
  if (!WinActive(SR) || times = 0)
    return
  if (FindText(&X, &Y, 1966, 1749, 2835, 1997, 0, 0, 再来一次)) {
    RandomSleep(251, 300)
    exhausted := PixelSearch(&_, &_, 1966, 1749, X, Y, '0xc84a32') || PixelSearch(&_, &_, 1966, 1749, X, Y, '0xeb4d3d')
    if (exhausted && !fuel) { ; 体力耗尽
      ing := false
      panel()
      return end()
    }
    ClickAndReturn(X, Y)
    if (exhausted && fuel) {
      fuel--
      while (true) {
        if (FindText(&X1, &Y1, 1440, 860, 2413, 1170, 0, 0, 燃料1)) {
          ClickAndReturn(X1, Y1)
        } else if (FindText(&X1, &Y1, 1440, 860, 2413, 1170, 0, 0, 燃料2)) {
          ; ClickAndReturn(X1, Y1) ; 默认选中
        } else {
          if (A_Index > 6) {
            MsgBox('未找到燃料图标', '提示', 'Icon! 0x40000')
            return end()
          }
          Sleep(251)
          continue
        }
        break
      }
      while (true) {
        if (FindText(&X2, &Y2, 1915, 1242, 2783, 1673, 0, 0, 确认)) {
          loop (3) {
            ClickAndReturn(X2, Y2)
            RandomSleep(200, 300)
          }
          break
        } else {
          if (A_Index > 6) {
            MsgBox('未找到确认按钮', '提示', 'Icon! 0x40000')
            return end()
          }
          Sleep(251)
        }
      }
      Sleep(251)
      ClickAndReturn(X, Y)
    }
    runtimes++
    if (times > 0) {
      times--
      if (times = 0) {
        times := -1
        return end()
      }
    }
  }
}

detecte_2880x1800() {
  global ing, times, runtimes, fuel
  static 再来一次 := "|<>*137$140.00000000C00000000000600000000003U00000000003k01zzzzy000s000000001k0w00TzzzzU00C000000000S0C007zzzzs3zzzzk0000007U7U0000w000zzzzw0000000w1s0000D000Dzzzz0000000D0zzzU03k000M3k400000001sDzzsDzzzk060s3U0000000T7zzy3zzzw03kC1w00000003ls070zzzz00S3US00000000Qw03kD0w3k07ksD000000004D7Us3UD0w00yC7U000000007VsS0s3kD007XXk000000003sSD0C0w3k00ksQ03zzzzz00w73k3zzzw000D200zzzzzk021ks0zzzz0DzzzzsDzzzzw0E0S00Dzzzk3zzzzy3zzzzz0D07U03UD0w0zzzzzU0000003k3s00s3kD000Ds000000001s0z00C0w3k007z000000000S0Dk0zzzzzU03zs000000007U7w0Dzzzzw01zzU00000003k1zU3zzzzz01ytw00000000w0ww0zzzzzk0zCDk0000000D0TDU0s00D00zXVy00000007UDVw0C003k0zUsDs0000001s7kDU3U00w0zkC0zk000000S7s1w0s00D0Dk3U7w000000D3w0DkC03zk3k0s0S0000003ny01y3U0zw0M0C01U000000tz00Dks0Dy0003U000000002D001sC01w0000s0000000001U006U"
  static 燃料1 := "|<>*137$109.zzzzzzzXzzzzzzzzzzzzzzzzzUDzzzzzzzzzzzzzzzzE1zzzzzzzzzzzzzzzyTkTzzzzzzzzzzzzzzyE77zzzzzzzzzzzzzzyE0Fzzzzzzzzzzzzzzy0zUTzzzzzzzzzzzzzy0TsDzzzzzzzzzzzDzy0Ty3zzzzzzzzzzwXzz0TzUzzzzzzzzzzw3zs0TzsDzzzzzzzzzsPzs2Tzw3zzzzzzzzzk3zw3Tzz1zzzzzzzzzk1zzlDzzkTzzzzzzzzk8zzz7zzw7zzzzzzzzk4zzzVzzy1zztjzzzzk7TzzszzzUTzsPzzzzs7nz3wzzzsDzs4Dzzzw48yVvzzzy3zs11zzztyAzsDzzzzczs0kDzzxwAzyXzzzzkDs083zzzkMlzlzzzzw7s040Tzzn8szV7zz0z1w0307zy3kszn1Tz07kQ01U3zz3zwznVbzk1w601k1zznzwzlUU3s0T301s0zzzzzzkkE0s0DUk1w0DzzxzzkQM0Q03s81y07zzwzzmTs0S00ya1z03zzyTzmzw0D00DdUzU1zzzzjmTw0D003kMzk0zzzzbkzw07000x4Ts0Tzzv3kTy03000NHTw0Dzzx7aDy03U004oTw07zzzT0Dy03U0018Dy03zzzU0zy030000GXz01zzzsXzy01zk004czVUzzzy3zy01zzs03CDlszzzzW7z01zyS00b7ryTzzzs7z01zyDU091zzjzzzy7zw1zz7s02kTzrzzzzXzy1zz7y00w7zzzzzzszs1zz3zU0T3zzzzzzzzk1yz7zs0Dkzzzzzzzrkly17z003wDzzzzzzU8Py07y001z3zzzzzz7sDk07z701zVzzzzzzXw7U07z7s1zsTzzzzzk03U03zY41zw7zzzzzw01U03zm01zz1zzzzzy01k030906zzozzzzzz00y0000XtjzxDzzzzzU2TzrsTDwvzy3zzzzzw0DzzzznzTzzczzzzzn05zzzzwzjzzsTzzzztk4zzzzz3rzzy7zzzzxw6Tzzzzs1zzzVzzzzyz37zzzzzU6TzkTzzzzTn3zzzzzy00zw7zzzzjz1zzzzzzDk3z3zzzznz0zzzzzzbz0Tkzzzzsy0Tzzzzzvzy3sDzzzzy0Dzzzzzxzzsy3zzzzS07zzzzzyzzz7Vzzzzz01zzzzzzTzznsTzzzzU0zzzzzzjzzww7zzzzk0TzzzzzrszyD1zzzzs0Dzzzzztw3zbkzzzzs03zzzzzwz8zlwDzzzw00zzzzzyTaTsz3zzzy00DzzzzzDnbyTUzzzz000TzzzzbwXy7sDzzzU00Tzzzzny1s3y7zzzk00TzzzzxzU01zVzzzw00zzjzzyTy00jkTzzz01zzvDzzDzbs3w7zzzs7xzy3zzbznw0T3zzzzzwzzUTzvzty0DkzzzzzsTzk7zwzwz07sTzzzzkBzw1zyDwT00aDzzzz06zz0Tzbw900Gzzzzy03Tzk7zlz4000jzzzz01jzw1zwTX200DzzzzU0tzz0Dz3V0007zzzzk0STzk3zk02003zzzzs0Drzw0zw02003zzzzw07wTz0Dz00001rzzzy03z3zk3zk0001vzzzz01zszw0TtU000xzzzzU0zy7z07zU000Szzzzk0zzVzk1zs000DTzzzk0TzsTw0zy000Dzzzzs0Dzy7z0Dz0007jzzzw07zy1zk3zk003rzzzy03zz0Tw0zw803vzzzz01zzk7y07wM01vzzzzU1zza0zU1wS01xzzzzk0zzlU7s0SM00xzzzzs0TzkM1y06s00wzzzzw0Dzs20DU0s00yzzzzy07zs0Y3s0MU0STzzzz03zw0DUy0200STzzzzU1zw07sDU0U0TDzzzzk0zy03y3s086TDzzzzw0Dy01z1y020zDzzzzy07z01zUTU00zDzzzzz03z00zs7s08zbzzzzzU1z00zy1y03wbzzzzzk0zU0TzUTU1tbzzzztw0DU0Tzc7s00Dzzzzwy07U0Dza0y01DzzzzyTU3U0Dzllbk3DzzzzyDk0U07zsozs0Tzzzzz7z0007zwNjw0TzzzzzVzw007zw6Rk0TzzzzzUzzv07zy3ntU7zzzzzUDzzU7zy0zzw1zzzzzU1zz07zy0Dzw0TzzzzU0zzU1zy03zw07zzzzU07z00Dy00Ts01zzzz001y003w007s00Dzzw000000000000000zzs0000000000000007zy0000000000000007zzw003s00DU00T000zzzz007y00Dw00Ts00zzzzs07zk0TzU0zy01zzzzy0Dzw0Tzs0zzk1zzzzzUDzz0Tzy0zzw1zzzzzs7zzkTzzUzzy1zzzzzw7zzsDzzkTzzUzzzzzz7zzyDzzwTzzszzzzzzXzzz7zzyDzzwTzzzzztzzzXzzz7zzyTzzs"
  static 燃料2 := "|<>*137$115.zzzzzzzk7zzzzzzzzzzzzzzzzzs0Tzzzzzzzzzzzzzzzzm07zzzzzzzzzzzzzzzzU33zzzzzzzzzzzzzzzzY0QTzzzzzzzzzzzzzzzU70DzzzzzzzzzzzzzzzU7w3zzzzzzzzzzzzzzzU7z8zzzzzzzzzzzzXzzU7zmDzzzzzzzzzzy1zzk7zw7zzzzzzzzzzy8zy07zz1zzzzzzzzzzwAzy0bzzkTzzzzzzzzzs1zz0rzzs7zzzzzzzzzs0zzwPzzy1zzzzzzzzzs4TzzszzzUzzzzzzzzzs2DzzwTzzsDzzXzzzzzs3bzzyDzzy3zzUbzzzzw3szkvDzzz0zzU8Tzzzy34TdSzzzzkDzU23zzzyr6TyDzzzzw7zU10zzzyw6TzUzzzzzFzU0k7zzzw6QzwTzzzzkTk081zzztYQTw9zzzzs7k040DzzMsQDwMTzk1yXk0307zz0ySDws9zy0TUs03U1zzlzzDwMAsz07sA03k0zzzzzDwA40DU0w203s0TzzzTzw6203U0T1U3w0DzzzTzw3X03k07kM3y07zzzDzy3z01s01w41z03zzzjzw7zU0w00TH1zU1zzzzvwLzU0w00DYlzk0zzzztw7zU0Q003eAzs0Tzzykw3zk0Q000mXTs0DzzzltXzk0C0009czw07zzzzknzk0A0002ETy03zzzs0Dzk0A0000Z7z01zzzy0zzk0Dz000NlzVUzzzzUzzk0DzzU04sTlsTzzzslzs07zzs01C7ryDzzzwEzs07zwz00H3zzbzzzzUzxU7zwTU0BUzzrzzzzkzzk7zwTs03uDzzzzzzwTz87zwDy00ybzzzzzzzby07zwDzU0T9zzzzzzzzw2DtyDy807oTzzzzzzw33Ds0Tw003x7zzzzzzkT1zs0TwA03z1zzzzzzsz0y00DwDU1zkzzzzzzw4US00DyDk1zwDzzzzzz00C00DzA41zz3zzzzzzU06007sW01zzUzzzzzzk070040E0bzzuTzzzzzw03w0000bvjzybzzzzzy01zzzlyTwvzz1zzzzzyU0zzzzzbyTzzoTzzzzyM0rzzzzszjzzwDzzzzzC0Hzzzzy7rzzy3zzzzzbUNzzzzzkFzzzczzzzzrs8Tzzzzy0TzzsDzzzzvyADzzzzzw00zy3zzzzwzg7zzzzzzC03z1zzzzyDw3zzzzzzbz0TkTzzzz7s1zzzzzznzy1w7zzzzps0zzzzzztzzsT1zzzzvs0Tzzzzzwzzz7kzzzzzc0DzzzzzyTzzlsDzzzzw03zzzzzzDzzwy3zzzzy01zzzzzzbxzzDUzzzzz00zzzzzznw7znsTzzzzU0Tzzzzzsz0ztw7zzzzk07zzzzzwTaDwT1zzzzs01zzzzzzDnbyDkTzzzw00Dzzzzzbxnzbw7zzzy000zzzzznyNzVz3zzzy000zzzzztz0S0zUzzzzU00zzzzzwzk00TsDzzzk01zzyzzzDz00/y3zzzw03zzvjzzbzly0zVzzzzUDvzw3zznzsz07kTzzzzztzz0TztzwzU3y7zzzzzszzk7zyTyTk0z3zzzzzkTzw1zzDzDk0BVzzzzzUCzz0Tzny2M00Izzzzw07Tzk7zszU8005zzzzy03jzw1zyDkU002zzzzz01vzz0Dz3sEE00zzzzzU0wzzk3zkM0E00Tzzzzk0Tjzs0zy00k00Tzzzzs0DsTy0DzU0U00Tzzzzw07wHzU3zw1000CTzzzy03zXzs0zsM0007Dzzzz01zsDy07z80003bzzzz00zz3zU1zw0001nzzzzU0Tzkzs0Ty0001vzzzzk0DzwDy0DzU000xzzzzs0Dzz3zU3zs000Szzzzw07zz0zs0Ty000STzzzy03zzUDy07z100DTzzzz01zzs1zU1z300DjzzzzU0zzn0Ts0TXU07bzzzzk0zzkk1y07n007rzzzzs0TzsA0TU0a007nzzzzw07zw007s0D003vzzzzy03zw0H1y07403tzzzzz01zy05kTU0203xzzzzzU0zy01w7s0801wzzzzzk0Tz00z1y020Nyzzzzzs0Dz00zkTU0URwzzzzzw07z00Ts7s083wTzzzzz03zU0Ts1y003wTzzzzzU1zU0Dz0zU0byTzzzzzk0zk0DzkDs0Dqzzzzzzs0Dk07zw1y032Tzzzzty07s07zx0TU00zzzzzwz03s03zwkDs04zzzzzyDU0s03zySDy0Azzzzzz7s0M01zz6bzU1zzzzzzXzU001zzXBzk1zzzzzzVzy001zzVna01zzzzzzUTzwU1zzUST40TzzzzzkDzzk1zzkDzzkDzzzzzU1zzk1zzU1zzk1zzzzzU0Tzk0zzU0Tzk0TzzzzU07zk07zU07zU07zzzzU00zU00zU00z000zzzy0000000000000003zzs0000000000000000Tzw0000000000000000Dzzk000U000U000U000Tzzz003z003z003z001zzzzk03zk03zk03zk03zzzzy03zy03zy03zy03zzzzzU3zzU3zzU3zzU3zzzzzk3zzk3zzk3zzk3zzzzzw3zzw3zzw3zzw3zzzzzz1zzz1zzz3zzz1zzzzzzVzzzVzzzVzzzVzzzzzzszzzszzzszzzszzzk"
  static 确认 := "|<>*117$39.00TzU000DzzU007zzz003zzzw00zzzzs0DzzzzU3zzzzw0Tzzzzk7zzzzz1zzzzzwDzzzzzXzzzzjyTzzzsznzzzy3yzzzzUzzzzzsDzzzzy3zzzzzUzzzxzsDzzz7y3zzzkTUzzzz1sDzzzw63zzzzk0zzzTz0Dzznzw3zzyTzkzzzlzzDzzwDzzzzzUzzzzzs3zzzzy0TzzzzU1zzzzw07zzzz00Tzzzk00zzzs001zzw0003zw00U"
  static end() {
    global ing
    ing := false
    SetTimer(detecte_2880x1800, 0)
  }
  if (!WinActive(SR) || times = 0)
    return
  if (FindText(&X, &Y, 1520, 1449, 2040, 1650, 0, 0, 再来一次)) {
    RandomSleep(251, 300)
    exhausted := PixelSearch(&_, &_, 1520, 1449, X, Y, '0xc84a32') || PixelSearch(&_, &_, 1520, 1449, X, Y, '0xeb4d3d')
    if (exhausted && !fuel) { ; 体力耗尽
      ing := false
      panel()
      return end()
    }
    ClickAndReturn(X, Y)
    if (exhausted && fuel) {
      fuel--
      while (true) {
        if (FindText(&X1, &Y1, 1331, 738, 1542, 969, 0, 0, 燃料1)) {
          ClickAndReturn(X1, Y1)
        } else if (FindText(&X1, &Y1, 1212, 730, 1454, 975, 0, 0, 燃料2)) {
          ; ClickAndReturn(X1, Y1) ; 默认选中
        } else {
          if (A_Index > 6) {
            MsgBox('未找到燃料图标', '提示', 'Icon! 0x40000')
            return end()
          }
          Sleep(251)
          continue
        }
        break
      }
      while (true) {
        if (FindText(&X2, &Y2, 1650, 1137, 1900, 1250, 0, 0, 确认)) {
          loop (3) {
            ClickAndReturn(X2, Y2)
            RandomSleep(200, 300)
          }
          break
        } else {
          if (A_Index > 6) {
            MsgBox('未找到确认按钮', '提示', 'Icon! 0x40000')
            return end()
          }
          Sleep(251)
        }
      }
      Sleep(251)
      ClickAndReturn(X, Y)
    }
    runtimes++
    if (times > 0) {
      times--
      if (times = 0) {
        times := -1
        return end()
      }
    }
  }
}

detecte_1920x1080() {
  global ing, times, runtimes, fuel
  static 再来一次 := "|<>*133$94.00000300000001U000000A000000k607zzy00s0000030s0TzzsDzzs0000C3000C00zzzU0000QTzU0k00UkM00001lzy7zzU733U00003i0MTzy0CAQ000000nXVUsM0Qlk000007CQ631U0n60zzzw0MtUTzy02CM3zzzk03U1zzs7zzzDzzz0kC063VUTzzw000030s0MA600z000000Q7k1UsQ07y000001UT0zzzw0zw0000063i3zzzk7gw00000sQQ1U0M1slw000033ks601UT31w0000QS1kM063kA3k0001rk3lU7s40k200002Q0760TU030000000U0+"
  static 燃料1 := "|<>*137$73.zzzzyzzzzzzzzzzzy3zzzzzzzzzzxsTzzzzzzzzzx1bzzzzzzzzzw71zzzzzzzzzw7szzzzzzzsTw7yDzzzzzztTs7zXzzzzzzljsLzkzzzzzzkDz/zwDzzzzzkbzszz7zmzzzkPzyzzlzkjzzs2yBzzsTk0zzvWzXzzybk4Dzz6rwzzzXs21zzOnwbz1ss00TwStxWzkSA0kDzzvwk1s7m0s7zyzwN0M1l0w3zyTxBUA0QEy1zzzxTUC074T0zzyQTU603FTUTzuOTk600gTUDzykDk600+Dk7zz0zk3s02XsXzzlzk3zs0gxtzzx7s3zC03DyzzzDz3zDU5LzTzznwXzbs1lzzzzzw3rby0wTzzzy6LkDk0DbzzzwSC07nUDXzzzz0607ucDszzzzU307Z0DyDzzzs3U007PzXzzzw1zzzjrzlzzzx0jzzvvzwTzzwk7zzyRzz7zzyQHzzzkTzlzzzDNzzzz07wzzzrszzzzjkSDzztkTzzzrzXXzzvk7zzzvzwszzzk3zzzxzzCDzzs1zzzyQzr7zzw0zzzzD3tlzzy0DzzzrhywTzz01zzzvqzD7zzU0TzzxwC7Xzzk0Tzzyz03szzw0zxzzDtkSDzzXvz3zrxw7Xzzztzkzvyw3tzzzkzwDwzK04zzz0Lz3zD000zzzUDzkzXa00zzzk7Ts7s0E0Tzzs3ly1z0E0Tzzw1wTUTk00Bzzy0z7s7u006zzy0Tly1z003Tzz0TyTUTk03zzzUDz3s7w01jzzk7zUy1y81rzzs3zcDUSM0vzzw1zm1s3E0vzzy0zk4S0k0Rzzz0Ts17UE0RzzzUDs1ls20Qzzzk7w1wS0VSzzzs3w0y7U0Szzzy1y0TVs2yzzzz0y0TsS0uzzzvUC0Tu7U0zzzts60DxWs4zzzww00DyNy1zzzyTs07yBg1zzzy7zs7z7TUTzzy1zs7z0zs7zzy0Ts3y0Ds1zzy03k0S03k0Tzs0000000001zs0000000000Tzk0S03k0S03zzw0zU7y0Tk3zzz0zw7zUzw3zzzkzy7zsTz3zzzwTzXzwTzXzy"
  static 燃料2 := "|<>*137$77.zzzzz3zzzzzzzzzzzy1zzzzzzzzzzzblzzzzzzzzzzyU9zzzzzzzzzzsDVzzzzzzzzzzUzXzzzzzzzxDy3zXzzzzzzzkzk7zXzzzzzzw7z1Tz3zzzzzzkjzpzz3zzzzzz1Tytzz3zvzzzw6zznzz7zUTzzsCT6zzy7y0Dzzb5zDzzy7s27zzwrzbzzy7k47zz8NyHzsyD003zktnv0zkSA0M7znzDa97UQ81kDzzzyAEC0Q87UTzxzsR0Q0RMT0TzvzXy0s0QEy0zzzSDs3U0sHw1zzgsTU600WLs3zzn9z0M00czU7zz8Dw0U00cz0Dzz9zk3y00Ay8zzz7z0Dzk1AxtzzzHy0ztk14zvzzzDz3zbk1lzzzzzDuDyDk1lzzzzzz4yszE3tzzzzy6Hk7s0Ddzzzzlkw0Tb0TXzzzzU1U0zD0zXzzzzU303yU3znzzzz0C0043TzHzzzy0TxkByrz7zzzz0zzztxzz7zzzq1Tzzsvzzbzzzi4zzzw3zz7zzzS9zzzz07yDzzyzXzzzzi0yDzzwy3zzzzTsSDzzyk7zzzyzySDzzz0DzzzxzyQTzzy0TzzzvzyQTzzw0zzzzrbyQTzzs0zzzzj1ywTzzk1zzzzTPxsTzzU0zzzyyrtszzz00zzzww71szzy03zzzxy07szzy0TyzzvzD/kzzz3rz3zryy1lzzzzDy3zbxs3lzzzsTy3zjvk2nzzy0ry3zDY00Tzzw1jy3zDA01zzzs3jy3z6101zzzk7jy1z0407zzzUDby1z000Bzzz0Tny1yM00vzzw0zly1zU01rzzs1zly1z003zzzk3zly1z007zzzUDzVy1z00Rzzz0Tz1y1wE0vzzy0zx1y1tU3jzzw1zk0y0Y07Tzzs3zUUS0k0Rzzzk7y0cS001vzzzUDw0sS0U7jzzz0Tk1sS0Vyzzzz0zU7kS01tzzzy1y0Dky0bbzzzw1w0zky0yTzzys3k1zky01zzzts707yFS0jzzznk40Twvy0zzzzbw00ztfs3zzzy7z83zVh07zzzwDzkDz3ywDzzzU7z0zs1zk7zzy07w0TU1y07zzk0100800k03zw00000000000zy00000000007zzU1y07s0TU1zzzU7y0Ts1zU7zzzUTy1zs7zUTzzzVzy7zsTzVzzzzbzyTztzzbzy"
  static 确认 := "|<>*108$29.0000003y000Tz003zzU0DzzU0zzzU3zzzUDzzzUTzzz1zzyT3zzsy7zzXwDzyDwTzszszDXzlwCDzXw8zy7w3zwDwDzsDwzzUTzzz0Tzzw0Tzzk0Tzz00Tzw00DzU007w0000008"
  static end() {
    global ing
    ing := false
    SetTimer(detecte_1920x1080, 0)
  }
  if (!WinActive(SR) || times = 0)
    return
  if (FindText(&X, &Y, 1009, 828, 1407, 1035, 0, 0, 再来一次)) {
    RandomSleep(251, 300)
    exhausted := PixelSearch(&_, &_, 1000, 850, X, Y, '0xc84a32') || PixelSearch(&_, &_, 1000, 850, X, Y, '0xeb4d3d')
    if (exhausted && !fuel) { ; 体力耗尽
      ing := false
      panel()
      return end()
    }
    ClickAndReturn(X, Y)
    if (exhausted && fuel) {
      fuel--
      while (true) {
        if (FindText(&X1, &Y1, 836, 379, 1083, 630, 0, 0, 燃料1)) {
          ClickAndReturn(X1, Y1)
        } else if (FindText(&X1, &Y1, 836, 379, 1083, 630, 0, 0, 燃料2)) {
          ; ClickAndReturn(X1, Y1) ; 默认选中
        } else {
          if (A_Index > 6) {
            MsgBox('未找到燃料图标', '提示', 'Icon! 0x40000')
            return end()
          }
          Sleep(251)
          continue
        }
        break
      }
      while (true) {
        if (FindText(&X2, &Y2, 996, 642, 1345, 829, 0, 0, 确认)) {
          loop (3) {
            ClickAndReturn(X2, Y2)
            RandomSleep(200, 300)
          }
          break
        } else {
          if (A_Index > 6) {
            MsgBox('未找到确认按钮', '提示', 'Icon! 0x40000')
            return end()
          }
          Sleep(251)
        }
      }
      Sleep(251)
      ClickAndReturn(X, Y)
    }
    runtimes++
    if (times > 0) {
      times--
      if (times = 0) {
        times := -1
        return end()
      }
    }
  }
}

; 点击目标坐标后返回原坐标
ClickAndReturn(x, y) {
  MouseGetPos(&ox, &oy)
  SimulateClick(x, y)
  RandomMouseMove(ox, oy)
}

/** 随机休眠，默认50~100ms */
RandomSleep(ms1 := 50, ms2 := 100) => Sleep(Random(ms1, ms2))

/** 鼠标随机移动至指定真实坐标 */
RandomMouseMove(TargetX, TargetY) {
  static MinSpeed := 48
  static MaxSpeed := 52
  MouseGetPos(&StartX, &StartY)
  Distance := Sqrt((TargetX - StartX) ** 2 + (TargetY - StartY) ** 2)
  ; 鼠标移动速度，适当缩放确保效果
  Speed := (MinSpeed + Random() * (MaxSpeed - MinSpeed)) * (A_ScreenWidth / 1920)
  ; 生成随机控制点用于贝塞尔曲线
  ControlPoint1X := StartX + Random() * (TargetX - StartX) / 2
  ControlPoint1Y := StartY + Random() * (TargetY - StartY) / 2
  ControlPoint2X := StartX + (TargetX - StartX) / 2 + Random() * (TargetX - StartX) / 2
  ControlPoint2Y := StartY + (TargetY - StartY) / 2 + Random() * (TargetY - StartY) / 2
  ; 使用贝塞尔曲线计算移动路径
  Steps := Ceil(Distance / Speed)
  Loop (Steps) {
    t := A_Index / Steps
    x := (1 - t) ** 3 * StartX + 3 * (1 - t) ** 2 * t * ControlPoint1X + 3 * (1 - t) * t ** 2 * ControlPoint2X + t ** 3 * TargetX
    y := (1 - t) ** 3 * StartY + 3 * (1 - t) ** 2 * t * ControlPoint1Y + 3 * (1 - t) * t ** 2 * ControlPoint2Y + t ** 3 * TargetY
    MouseMove(x, y, 0)
    RandomSleep(5, 10)
  }
}

/** 模拟点击行为，移动至指定真实坐标点击n次 */
SimulateClick(x?, y?, clickCount := 1) {
  if (IsSet(x) && IsSet(y)) {
    RandomMouseMove(x + Random(-2, 2), y + Random(-2, 2))
  }
  Loop (clickCount) {
    Click("Left Down")
    Sleep(Random(50, 80))
    Click("Left Up")
    Sleep(Random(160, 251))
  }
}