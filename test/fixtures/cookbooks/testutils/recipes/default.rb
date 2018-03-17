user 'u1'
group 'g1'
group 'nobody'

# hard set mode bits

directory '/u01/make/sub/directories/last' do
  recursive true
end
file '/u01/make/sub/directories/last/leaf' do
end
fileutils '/u01/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode 0o555
  file_mode 0o640
end

# Set mode bits using +/- mode settings

directory '/u02/make/sub/directories/last' do
  recursive true
end
file '/u02/make/sub/directories/last/leaf' do
  mode 0o755
end
fileutils '/u02/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode 'g+w'
  file_mode 'u-w'
end

# Set using a file filter

# Set following symlink
directory '/u03/make/sub/directories/last' do
  recursive true
end
directory '/u04'
link '/u03/make/sub/directories/u04' do
  to '/u04'
end
file '/u03/make/sub/directories/last/leaf' do
end
fileutils '/u03/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode 'g+w'
  file_mode 'o-w'
  follow_symlink true
end

# Set and do not follow symlink
directory '/u05/make/sub/directories/last' do
  recursive true
end
directory '/u06'
link '/u05/make/sub/directories/u06' do
  to '/u06'
end
file '/u05/make/sub/directories/last/leaf' do
end
fileutils '/u05/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode 'g+w'
  file_mode 'o-w'
  follow_symlink false
end

# Set mode using an array of +/- settings
# Set mode only on files
directory '/u07/make/sub/directories/last' do
  recursive true
end
file '/u07/make/sub/directories/last/leaf' do
  mode 0o755
end
fileutils '/u07/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode ['g+w', 'u-r']
  file_mode ['u-w', 'go-r']
  only_files true
end

# Set mode only on directories
directory '/u08/make/sub/directories/last' do
  recursive true
end
file '/u08/make/sub/directories/last/leaf' do
  mode 0o755
end
fileutils '/u08/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode ['g+w', 'ou-rx']
  file_mode 'o-w'
  only_directories true
end

# Set group only
directory '/u09/make/sub/directories/last' do
  recursive true
end
fileutils '/u09/make/sub' do
  group 'g1'
end

# Set owner only
directory '/u10/make/sub/directories/last' do
  recursive true
end
fileutils '/u10/make/sub' do
  owner 'u1'
end

# Change nothing, should not blow up
directory '/u11/make/sub/directories/last' do
  recursive true
end
fileutils '/u11/make/sub' do
end

# Change just the mode
directory '/u12/make/sub/directories/last' do
  recursive true
end
fileutils '/u12/make/sub' do
  directory_mode 0o771
end

# Non recursive examples
directory '/u13/make/sub/directories/last' do
  recursive true
  mode 0o755
end
file '/u13/make/file' do
  mode 0o644
end
file '/u13/make/sub/file' do
  mode 0o644
end
fileutils '/u13/make/sub' do
  recursive false
  directory_mode 0o771
end
fileutils '/u13/make' do
  recursive false
  only_files true
  directory_mode 0o770
  file_mode 0o700
end

# delete a directory tree
directory '/ud1/make/sub/directories/last' do
  recursive true
end
directory '/ud16'
link '/ud1/make/sub/directories/d16' do
  to '/ud16'
end
file '/ud1/make/sub/directories/last/leaf' do
end
fileutils '/ud1/make/sub' do
  action :delete
end

# delete only files
directory '/ud2/make/sub/directories/last' do
  recursive true
end
file '/ud2/make/sub/directories/last/leaf'
file '/ud2/make/sub/directories/last/leaf1'
file '/ud2/make/sub/directories/last/leaf2'
file '/ud2/make/sub/directories/leaf3'
fileutils '/ud2/make/sub' do
  action :delete
  only_files true
  force true
end

# Issue 1 - minimal idempotency check
test_dir = '/tmp/test_dir'
directory test_dir do
  action :create
end
fileutils test_dir do
  group 'nobody'
end

# Issue 2 - Add the quiet option

directory '/ui2/make/sub/directories/last' do
  recursive true
end
file '/ui2/make/sub/directories/last/leaf' do
end
file '/ui2/make/sub/directories/last/leaf1' do
end
fileutils '/ui2/make/sub' do
  group 'g1'
  owner 'u1'
  directory_mode 0o555
  file_mode 0o640
  quiet true
end

fileutils '/ui2/make/sub/directories/last' do
  action :delete
  quiet true
end
