require 'sinatra'
require 'mongoid'
require 'json/ext'

Dir.glob("./{config,models}/*.rb").each {|f| require f}

get '/' do
  all = Linux.all
  message = 'Список роутов и данные по вызовам роутов'
  erb :index, locals: { message: message, all: all }
end

get '/system/:type' do
  if params[:type] == 'mem'
    data = `free -m`
    message = 'Загрузка памяти'
  elsif params[:type] == 'proc'
    data = `cat /proc/cpuinfo`
    message = 'Инфа про проц'
  elsif params[:type] == 'ls'
    data = `ls`
    message = 'Список папок и файлов'
  elsif params[:type] == 'hdd'
    data = `df -h`
    message = 'Загрузка диска'
  end

  already_data = Linux.where(name: params[:type]).last

  if !data.nil? && already_data.nil?
    new_str = Linux.new(name: params[:type], value: data, count: 1)
    new_str.save
  else
    already_data.value = data
    already_data.count += 1
    already_data.save
  end
  erb :tmp, locals: { message: message, data: data }
end

get '/reboot' do
  `sudo reboot`
end