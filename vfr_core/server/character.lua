AddEventHandler('playerConnecting', function(nick, setKickReason, deferrals)
    local license = GetPlayerIdentifiers(source)[1]
    local ssnbase = nil

    GenerateSSN(function (ssn)
        ssnbase = ssn
    end)

    local StartCashAndAccounts = json.encode(Config.Accounts)


    MySQL.Async.fetchAll('SELECT * FROM users WHERE license = @license', {
        ['@license'] = license
    }, function(users)
        
        -- print(json.encode(users[1]['ssn']))
        -- print(json.encode(users[1]['ssn']))
        if #users == 0 then
            MySQL.Async.execute('INSERT INTO users (ssn, license, usergroup, accounts) VALUES (@ssn, @license, @usergroup, @accounts)', {
                ['@ssn'] = tostring(ssnbase),
                ['@license'] = license,
                ['@usergroup'] = 'user',
                ['@accounts'] = tostring(StartCashAndAccounts),
            }, function(rowsChanged)
                print('[VFR] Added User')
            end)
        else
            print('[VFR] Loaded User')
        end
    end)
    
end)

AddEventHandler('playerDropped', function (reason)
    print('[VFR] Updated Actual Player Data')
    TriggerClientEvent('VFR:updateActualPlayerData', source)
end)

function GenerateSSN(callback)
    MySQL.Async.fetchAll('SELECT * FROM users', function(users)
        callback(#users + 1)
    end)
end

RegisterNetEvent('VFR:GetPlayerData', function()
    local source = source
    local license = GetPlayerIdentifiers(source)[1]
    local playerData = nil

    MySQL.Async.fetchAll('SELECT * FROM users WHERE license = @license', {
        ['@license'] = license
    }, function(users)
        if #users > 0 then
            playerData = users[1]
        end

        TriggerClientEvent('VFR:loadPlayerData', source, playerData)
    end)
end)

RegisterNetEvent('VFR:updatePlayerData', function(data)
    MySQL.Async.execute('UPDATE users SET usergroup = @usergroup, accounts = @accounts WHERE ssn = @ssn AND license = @license', {
        ['@ssn'] = data.ssn,
        ['@license'] = data.license,
        ['@usergroup'] = data.usergroup,
        ['@accounts'] = data.accounts,
    }, function(rowsChanged)
        print('[VFR] Updated Data')
    end)
    
    
end)