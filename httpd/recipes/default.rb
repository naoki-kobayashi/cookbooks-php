# apache�̃C���X�g�[�� CentOS�̏ꍇ
package "httpd" do
    action :install
end
 
# apache�̋N�� CentOS�̏ꍇ
service "httpd" do
    action [:start, :enable]
end
 
template "/var/www/html/index.html" do
    source "index.html.erb"
    mode 0644
end