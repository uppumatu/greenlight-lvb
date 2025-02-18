# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
#
# Copyright (c) 2022 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# Greenlight is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with Greenlight; if not, see <http://www.gnu.org/licenses/>.

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:setting) }
    it { is_expected.to validate_presence_of(:provider) }

    context 'image validations' do
      it 'passes if the attachement is a png' do
        site_setting = build(:site_setting, image: fixture_file_upload(file_fixture('default-avatar.png'), 'image/png'))
        expect(site_setting).to be_valid
      end

      it 'passes if the attachement is a jpg' do
        site_setting = build(:site_setting, image: fixture_file_upload(file_fixture('default-avatar.jpg'), 'image/jpeg'))
        expect(site_setting).to be_valid
      end

      it 'passes if the attachement is a svg' do
        site_setting = build(:site_setting, image: fixture_file_upload(file_fixture('default-avatar.svg'), 'image/svg+xml'))
        expect(site_setting).to be_valid
      end

      it 'fails if the attachement isn\'t of image type' do
        site_setting = build(:site_setting, image: fixture_file_upload(file_fixture('default-pdf.pdf'), 'application/pdf'))
        expect(site_setting).to be_invalid
        expect(site_setting.errors).to be_of_kind(:image, :content_type_invalid)
      end

      it 'fails if the attachement is too large' do
        site_setting = build(:site_setting, image: fixture_file_upload(file_fixture('large-avatar.jpg'), 'image/jpeg'))
        expect(site_setting).to be_invalid
        expect(site_setting.errors).to be_of_kind(:image, :file_size_not_less_than)
      end
    end
  end
end
