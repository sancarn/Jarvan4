;Define ability q
$q::
  Send,q
  SoundPlay, %A_ScriptDir%\sounds\ability_q.wmv
return

;Define ability w
$w::
  Send,w
  SoundPlay, %A_ScriptDir%\sounds\ability_w.wmv
return

;Define ability e
$e::
  Send,e
  SoundPlay, %A_ScriptDir%\sounds\ability_e.wmv
return

;Define ability r
$r::
  Send,r
  SoundPlay, %A_ScriptDir%\sounds\ability_r.wmv
return

;Define joke
$+1::
  send,+1
  SoundPlay, %A_ScriptDir%\sounds\joke.wmv
return

;Define taunt
$+2::
  send,+2
  SoundPlay, %A_ScriptDir%\sounds\taunt.wmv
return

;Define dance
$+3::
  send,+3
  SoundPlay, %A_ScriptDir%\sounds\dance.wmv
return

;Define laugh
$+4::
  send,+4
  SoundPlay, %A_ScriptDir%\sounds\laugh.wmv
return

;Define Care/FallBack
$^LButton::
  send, ^{LButton}
  SoundPlay, %A_ScriptDir%\sounds\cation.wmv
return

;OnEvent Danger
Danger:
  SoundPlay, %A_ScriptDir%\sounds\danger.wmv
return

;OnEvent Assistance
Assistance:
  SoundPlay, %A_ScriptDir%\sounds\assist.wmv
return

;On Event
Missing:
  SoundPlay, %A_ScriptDir%\sounds\missing.wmv
return

OnMyWay:
  
  SoundPlay, %A_ScriptDir%\sounds\onmyway.wmv
return

PlayRand(sName,max,extension:="wmv") {
  ;get a random number
  Random, num, 1, %max%
  
  ;play random sound
  SoundPlay, %A_ScriptDir%\sounds\%sName%%num%.%extension%
}
