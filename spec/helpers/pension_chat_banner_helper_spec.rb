RSpec.describe PensionChatBannerHelper, type: :helper do
  describe '#display_pension_chat_banner?' do
    before do
      allow(helper).to receive(:request).and_return(request)
    end

    context 'category is "pensions-and-retirement"' do
      let(:request) do
        double(path: '/en/retirement-income-options/')
      end

      it 'returns true' do
        expect(helper.display_pension_chat_banner?).to eq(true)
      end
    end

    context 'categories other than "pensions-and-retirement"' do
      let(:request) do
        double(path: '/en/articles/changing-your-career-following-redundancy')
      end

      it 'returns false' do
        expect(helper.display_pension_chat_banner?).to eq(false)
      end
    end

    describe '#whitelist' do
      context 'category is "pensions-and-retirement"' do
        subject(:first_level_slugs) { helper.send(:first_level_slugs) }

        it 'returns list of first level slugs' do
          expected_slugs_en = %w[
            pensions-and-retirement
            retirement-income-options
            annuities
          ]

          expected_slugs_cy = %w[
            pensiynau-ac-ymddeoliad
            opsiynau-incwm-ymddeoliad
            annuities
          ]

          expect(first_level_slugs).to match(
            expected_slugs_en + expected_slugs_cy
          )
        end
      end

      context 'second level slugs of "pensions-and-retirement"' do
        subject(:second_level_slugs) { helper.send(:second_level_slugs) }

        let(:expected_second_level_slugs_en) do
          %w[
            saving-for-retirement
            types-of-pensions
            automatic-enrolment
            pension-basics
            using-your-pension-pot
            getting-advice-about-retirement
            state-pension-and-benefits
            managing-money-and-planning-ahead
            help-in-later-life
            more-information
            retirement-income-tool
            compare-annuities
          ]
        end

        let(:expected_second_level_slugs_cy) do
          %w[
            offeryn-incwm-ymddeoliad
            chymharu-blwydd-daliadau
          ]
        end

        it 'returns list of second level slugs' do
          expect(second_level_slugs).to match(
            expected_second_level_slugs_en + expected_second_level_slugs_cy
          )
        end
      end

      context 'legacy_contents' do
        subject(:legacy_content_slugs) { helper.send(:legacy_content_slugs) }

        it 'returns list of legacy content slugs' do
          expected_legacy_slugs_en = %w[
            retirement-income-tool
            compare-annuities
          ]

          expected_legacy_slugs_cy = %w[
            offeryn-incwm-ymddeoliad
            chymharu-blwydd-daliadau
          ]

          expect(legacy_content_slugs).to match(
            expected_legacy_slugs_en + expected_legacy_slugs_cy
          )
        end
      end

      context 'third level categories' do
        subject(:third_level_slugs) { helper.send(:third_level_slugs) }

        let(:fixture) { Rails.root + 'spec/fixtures/categories.yml' }

        it 'returns list of third level category slugs' do
          expected_third_level_slugs_en = YAML.load_file(fixture)['en']['third_level_ids']
          expected_third_level_slugs_cy = YAML.load_file(fixture)['cy']['third_level_ids']

          expect(third_level_slugs).to match_array(
            expected_third_level_slugs_en +
            expected_third_level_slugs_cy
          )
        end
      end

      context 'landing page slugs' do
        subject(:landing_page_slugs) { helper.send(:landing_page_slugs) }

        it 'returns a list of landing page path slugs' do
          expected_landing_page_slugs = [
            '',
            'budgeting',
            'pension-savings-timeline',
            'cyllidebu',
            'llinell-amser-cynilion-pensiwn'
          ]

          expect(landing_page_slugs).to match(expected_landing_page_slugs)
        end
      end
    end
  end
end
