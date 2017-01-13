require 'rspec_helper.rb'

include DirHelper
context 'Directory utility' do
  describe 'method who_mask' do
    it 'should parse read, write, execute mode settings' do
      expect(who_mask('r')).to eq(0444)
      expect(who_mask('w')).to eq(0222)
      expect(who_mask('x')).to eq(0111)
      expect(who_mask('+rwx')).to eq(0777)
      expect(who_mask('ogu-xwr')).to eq(0777)
    end
  end

  describe 'method access_mask' do
    it 'should parse owner, group, other mode settings' do
      expect(access_mask('o')).to eq(0700)
      expect(access_mask('g')).to eq(0070)
      expect(access_mask('u')).to eq(0007)
      expect(access_mask('ugo+rwx')).to eq(0777)
      expect(access_mask('ogu-r')).to eq(0777)
      expect(access_mask('+r')).to eq(0777)
      expect(access_mask('-w')).to eq(0777)
    end
  end

  describe 'method new_mode' do
    it 'should combine the existing mode and new settings' do
      expect(new_mode(0755, 'ugo+x')).to eq(0755)
      expect(new_mode(0755, 'ogu-r')).to eq(0311)
      expect(new_mode(0750, '+r')).to eq(0754)
      expect(new_mode(0755, '-w')).to eq(0555)
      expect(new_mode(0644, 'ug+x')).to eq(0655)
      expect(new_mode(0755, 'ou-r')).to eq(0351)
    end
  end

  describe 'method new_mode' do
    it 'should combine the existing mode and new settings' do
      expect(new_mode(0755, 'ugo+x')).to eq(0755)
      expect(new_mode(0755, 'ogu-r')).to eq(0311)
      expect(new_mode(0750, '+r')).to eq(0754)
      expect(new_mode(0755, '-w')).to eq(0555)
      expect(new_mode(0644, 'ug+x')).to eq(0655)
      expect(new_mode(0755, 'ou-r')).to eq(0351)
      expect(new_mode(0755, 0644)).to eq(0644)
      expect(new_mode(0755, ['o-x', 'g-r', 'u-x'])).to eq(0614)
      expect(new_mode(0755, ['g+w', 'ou-rx'])).to eq(0270)
    end
  end
end
