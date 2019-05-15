
callbacks.removeScripts id:#testCallback

callbacks.addScript #filePreSaveProcess "print (callbacks.notificationParam())" id:#testCallback





pda_maincam = $

callbacks.addScript #filePostSave: