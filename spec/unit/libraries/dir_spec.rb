require 'rspec_helper.rb'

include DirHelper
context 'Directory utility' do
  describe 'method prm_mask' do
    it 'should parse read, write, execute mode settings' do
      expect(prm_mask('r')).to eq(0444)
      expect(prm_mask('w')).to eq(0222)
      expect(prm_mask('x')).to eq(0111)
      expect(prm_mask('t')).to eq(01000)
      expect(prm_mask('s+u')).to eq(04000)
      expect(prm_mask('s+g')).to eq(02000)
      expect(prm_mask('s+ugt')).to eq(07000)
      expect(prm_mask('+rwx')).to eq(0777)
      expect(prm_mask('ugo-xwr')).to eq(0777)
      expect(prm_mask('ugo-xwr')).to eq(0777)
    end
  end

  describe 'method who_mask' do
    it 'should parse owner, group, other mode settings' do
      expect(who_mask('u')).to eq(07700)
      expect(who_mask('g')).to eq(07070)
      expect(who_mask('o')).to eq(07007)
      expect(who_mask('a')).to eq(07777)
      expect(who_mask('ugo+rwx')).to eq(07777)
      expect(who_mask('ogu-r')).to eq(07777)
      expect(who_mask('+r')).to eq(07777)
      expect(who_mask('-w')).to eq(07777)
    end
  end

  describe 'method new_mode' do
    it 'should combine the existing mode and new settings' do
      expect(new_mode(0755, 'ugo+x')).to eq(0755)
      expect(new_mode(0755, 'ogu-r')).to eq(0311)
      expect(new_mode(0750, '+r')).to eq(0754)
      expect(new_mode(0755, '-w')).to eq(0555)
      expect(new_mode(0644, 'go+x')).to eq(0655)
      expect(new_mode(0755, 'ou-r')).to eq(0351)
    end
  end

  describe 'method new_mode' do
    it 'should combine the existing mode and new settings' do
      expect(new_mode(0755, 'ugo+x')).to eq(0755)
      expect(new_mode(0755, 'ogu-r')).to eq(0311)
      expect(new_mode(0750, '+r')).to eq(0754)
      expect(new_mode(0755, '-w')).to eq(0555)
      expect(new_mode(0644, 'go+x')).to eq(0655)
      expect(new_mode(0755, 'uo-r')).to eq(0351)
      expect(new_mode(0755, 0644)).to eq(0644)
      expect(new_mode(0755, ['u-x', 'g-r', 'o-x'])).to eq(0614)
      expect(new_mode(0755, ['g+w', 'uo-rx'])).to eq(0270)
    end
  end
end
