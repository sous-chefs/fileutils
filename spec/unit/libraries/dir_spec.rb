require 'rspec_helper.rb'

include DirChangeHelper
include DirDeleteHelper
context 'Directory utility' do
  describe 'method prm_mask' do
    it 'should parse read, write, execute mode settings' do
      expect(prm_mask('r')).to eq(0o444)
      expect(prm_mask('w')).to eq(0o222)
      expect(prm_mask('x')).to eq(0o111)
      expect(prm_mask('t')).to eq(0o1000)
      expect(prm_mask('s+u')).to eq(0o4000)
      expect(prm_mask('s+g')).to eq(0o2000)
      expect(prm_mask('s+ugt')).to eq(0o7000)
      expect(prm_mask('+rwx')).to eq(0o777)
      expect(prm_mask('ugo-xwr')).to eq(0o777)
      expect(prm_mask('ugo-xwr')).to eq(0o777)
    end
  end

  describe 'method who_mask' do
    it 'should parse owner, group, other mode settings' do
      expect(who_mask('u')).to eq(0o7700)
      expect(who_mask('g')).to eq(0o7070)
      expect(who_mask('o')).to eq(0o7007)
      expect(who_mask('a')).to eq(0o7777)
      expect(who_mask('ugo+rwx')).to eq(0o7777)
      expect(who_mask('ogu-r')).to eq(0o7777)
      expect(who_mask('+r')).to eq(0o7777)
      expect(who_mask('-w')).to eq(0o7777)
    end
  end

  describe 'method new_mode' do
    it 'should combine the existing mode and new settings' do
      expect(new_mode(0o755, 'ugo+x')).to eq(0o755)
      expect(new_mode(0o755, 'ogu-r')).to eq(0o311)
      expect(new_mode(0o750, '+r')).to eq(0o754)
      expect(new_mode(0o755, '-w')).to eq(0o555)
      expect(new_mode(0o644, 'go+x')).to eq(0o655)
      expect(new_mode(0o755, 'ou-r')).to eq(0o351)
    end
  end

  describe 'method new_mode' do
    it 'should combine the existing mode and new settings' do
      expect(new_mode(0o755, 'ugo+x')).to eq(0o755)
      expect(new_mode(0o755, 'ogu-r')).to eq(0o311)
      expect(new_mode(0o750, '+r')).to eq(0o754)
      expect(new_mode(0o755, '-w')).to eq(0o555)
      expect(new_mode(0o644, 'go+x')).to eq(0o655)
      expect(new_mode(0o755, 'uo-r')).to eq(0o351)
      expect(new_mode(0o755, 0o644)).to eq(0o644)
      expect(new_mode(0o755, ['u-x', 'g-r', 'o-x'])).to eq(0o614)
      expect(new_mode(0o755, ['g+w', 'uo-rx'])).to eq(0o270)
    end
  end
end
