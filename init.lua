function exec(filename)
  if (filename == nil) then
    filename = ''
  end

  filename = filename:gsub('%s+', '')
  
  if (filename == '') then
    error('Error - no file has been provided.')    
  end

  local filelc = filename .. '.lc'
  local filelua = filename .. '.lua'
  
  if (file.exists(filelc)) then
    dofile(filelc)
  elseif (file.exists(filelua)) then
    node.compile(filelua)
    dofile(filelc)
  else
    error('Provided file does not exist.')
  end
end

exec('telnet')
exec('program')
