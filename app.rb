require 'sinatra'

get '/' do
  message = 'Список роутов'
  erb :index, layout: :application
end

get '/mem' do
  data = `free -m`
  message = 'Загрузка памяти'
  erb :tmp, layout: :application, locals: { data: data, message: message }
end

get '/proc' do
  data = `cat /proc/cpuinfo`
  message = 'Инфа про проц'
  erb :tmp, layout: :application, locals: { data: data, message: message }
end

get '/proc-grep' do
  data = `cat /proc/cpuinfo | grep model`
  message = 'Инфа про проц (| grep model)'
  erb :tmp, layout: :application, locals: { data: data, message: message }
end

get '/ls' do
  data = `ls`
  message = 'Список папок и файлов'
  erb :tmp, layout: :application, locals: { data: data, message: message }
end

get '/hdd' do
  data = `df -h`
  message = 'Загрузка диска'
  erb :tmp, layout: :application, locals: { data: data, message: message }
end

get '/reboot' do
  `sudo reboot`
end