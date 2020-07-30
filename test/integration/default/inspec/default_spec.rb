# 'fileutils should'
# 'hardset mode'
describe file('/u01/make/sub') do
  it 'should set first directory mode' do
    expect(subject).to be_mode(0555)
  end
  it 'should set first directory owner' do
    expect(subject).to be_owned_by('u1')
  end
  it 'should set first directory group' do
    expect(subject).to be_grouped_into('g1')
  end
end
describe file('/u01/make/sub/directories/last') do
  it 'should set last directory mode' do
    expect(subject).to be_mode(0555)
  end
  it 'should set last directory owner' do
    expect(subject).to be_owned_by('u1')
  end
  it 'should set last directory group' do
    expect(subject).to be_grouped_into('g1')
  end
end
describe file('/u01/make/sub/directories/last/leaf') do
  it 'should set last file mode' do
    expect(subject).to be_mode(0640)
  end
  it 'should set last file owner' do
    expect(subject).to be_owned_by('u1')
  end
  it 'should set last file group' do
    expect(subject).to be_grouped_into('g1')
  end
end

# 'Add or subtract mode settings'
describe file('/u02/make/sub') do
  it 'should add to directory mode' do
    expect(subject).to be_mode(0775)
  end
end
describe file('/u02/make/sub/directories/last/leaf') do
  it 'should remove from file mode' do
    expect(subject).to be_mode(0555)
  end
end

# 'Should follow symlinks when true'
describe file('/u04') do
  it 'should add to symlink directory mode' do
    expect(subject).to be_mode(0775)
  end
  it 'should set owner' do
    expect(subject).to be_owned_by('u1')
  end
  it 'should set group' do
    expect(subject).to be_grouped_into('g1')
  end
end

# 'Should not follow symlinks when false'
describe file('/u06') do
  it 'should not add to symlink directory mode' do
    expect(subject).to be_mode(0755)
  end
  it 'should not set owner' do
    expect(subject).to be_owned_by('root')
  end
  it 'should not set group' do
    expect(subject).to be_grouped_into('root')
  end
end

# 'Should change only files'
describe file('/u07/make/sub/directories/last') do
  it 'should not update directory' do
    expect(subject).to be_mode(0755)
  end
end
describe file('/u07/make/sub/directories/last/leaf') do
  it 'should update file using an array of settings' do
    expect(subject).to be_mode(0511)
  end
end

# 'Should change only directories'
describe file('/u08/make/sub') do
  it 'should update directory' do
    expect(subject).to be_mode(0270)
  end
end
describe file('/u08/make/sub/directories/last') do
  it 'should update directory' do
    expect(subject).to be_mode(0270)
  end
end
describe file('/u08/make/sub/directories/last/leaf') do
  it 'should not update file' do
    expect(subject).to be_mode(0755)
  end
end

# 'Should be able to set things separately'
describe file('/u09/make/sub/directories/last') do
  it 'should set group only' do
    expect(subject).to be_owned_by('root')
    expect(subject).to be_grouped_into('g1')
  end
end

describe file('/u10/make/sub/directories/last') do
  it 'should set user only' do
    expect(subject).to be_owned_by('u1')
    expect(subject).to be_grouped_into('root')
  end
end

describe file('/u11/make/sub/directories/last') do
  it 'should change nothing' do
    expect(subject).to be_owned_by('root')
    expect(subject).to be_grouped_into('root')
  end
end

describe file('/u12/make/sub/directories/last') do
  it 'should change mode only' do
    expect(subject).to be_mode(0771)
  end
end

describe file('/u13/make/sub/directories/last') do
  it 'non-recursive should not change depth of 2' do
    expect(subject).to be_mode(0755)
  end
end

describe file('/u13/make/sub/directories') do
  it 'non-recursive should change depth of 1' do
    expect(subject).to be_mode(0771)
  end
end

describe file('/u13/make/sub') do
  it 'non-recursive should change depth of 0' do
    expect(subject).to be_mode(0771)
  end
end

describe file('/u13/make') do
  it 'non-recursive files_only should not change depth of 0' do
    expect(subject).to be_mode(0755)
  end
end

describe file('/u13/make/file') do
  it 'non-recursive files_only should change files depth of 1' do
    expect(subject).to be_mode(0700)
  end
end

describe file('/u13/make/sub/file') do
  it 'non-recursive files_only should not change files depth of 2' do
    expect(subject).to be_mode(0644)
  end
end

# 'Should delete directories'
describe file('/ud1/make/sub') do
  it 'should delete directory' do
    expect(subject).not_to exist
  end
end

# 'Should delete only files'
describe file('/ud2/make/sub/directories/last') do
  it 'should not delete directories' do
    expect(subject).to exist
  end
end
describe file('/ud2/make/sub/directories/last/leaf') do
  it 'should delete files' do
    expect(subject).not_to exist
  end
end
describe file('/ud2/make/sub/directories/last/leaf2') do
  it 'should delete files' do
    expect(subject).not_to exist
  end
end
describe file('/ud2/make/sub/directories/leaf3') do
  it 'should delete files' do
    expect(subject).not_to exist
  end
end

# 'Should process quietly files'
describe file('/ui2/make/sub/directories') do
  it 'should be owned by u1' do
    expect(subject).to be_owned_by('u1')
  end
end
describe file('/ui2/make/sub/directories/last/leaf') do
  it 'should delete files' do
    expect(subject).not_to exist
  end
end
