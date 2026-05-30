param(
    [Parameter(Mandatory)]
    [string]$ConfigFile
)

$config = Get-Content $ConfigFile -Raw | ConvertFrom-Json

$tunnel = Start-Process `
    -PassThru `
    -WindowStyle Hidden `
    -FilePath "plink" `
    -ArgumentList "-batch -agent -N -P $($config.ssh.port) -l $($config.ssh.user) -L $($config.tunnel.localPort):$($config.tunnel.address):$($config.tunnel.externalPort) $($config.ssh.server)"

Start-Sleep -Seconds $config.tunnel.sshWaitTime

Start-Process `
    -Wait `
    -FilePath $config.app.path `
    -ArgumentList $config.app.arguments

Stop-Process $tunnel.Id