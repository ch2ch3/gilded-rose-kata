require 'gilded_rose'

RSpec.describe '#update_quality' do
  context 'with a single item' do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { Item.new(name,
                          initial_sell_in,
                          initial_quality) }

    before(:each) do
      update_quality([item])
    end

    subject { item }

    context 'normal item' do
      let(:name) { 'NORMAL ITEM' }

      it 'should decrease sell_in by 1' do
        expect(subject.sell_in).to eq(initial_sell_in-1)
      end

      context 'before sell date' do
        it 'should decrease quality by 1' do
          expect(subject.quality).to eq(initial_quality-1)
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'should decrease quality by 2' do
          expect(subject.quality).to eq(initial_quality-2)
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }

        it 'should decrease quality by 2' do
          expect(subject.quality).to eq(initial_quality-2)
        end
      end

      context 'of zero quality' do
        let(:initial_quality) { 0 }

        it 'should not change quality' do
          expect(subject.quality).to eq(initial_quality)
        end
      end
    end

    context 'Aged Brie' do
      let(:name) { 'Aged Brie' }

      it 'should decrease sell_in by 1' do
        expect(subject.sell_in).to eq(initial_sell_in-1)
      end

      context 'before sell date' do
        it 'should increase quality by 1' do
          expect(subject.quality).to eq(initial_quality+1)
        end

        context 'with max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'should increase quality by 2' do
          expect(subject.quality).to eq(initial_quality+2)
        end

        context 'near max quality' do
          let(:initial_quality) { 49 }

          it 'should increase quality by 1' do
            expect(subject.quality).to eq(initial_quality+1)
          end
        end

        context 'with max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }

        it 'should increase quality by 2' do
          expect(subject.quality).to eq(initial_quality+2)
        end

        context 'with max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end
    end

    context 'Sulfuras' do
      let(:initial_quality) { 80 }
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      it 'should not change sell_in' do
        expect(subject.sell_in).to eq(initial_sell_in)
      end

      context 'before sell date' do
        it 'should not change quality' do
          expect(subject.quality).to eq(initial_quality)
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'should not change quality' do
          expect(subject.quality).to eq(initial_quality)
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }

        it 'should not change quality' do
          expect(subject.quality).to eq(initial_quality)
        end
      end
    end

    context 'Backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      it 'should decrease sell_in by 1' do
        expect(subject.sell_in).to eq(initial_sell_in-1)
      end

      context 'long before sell date' do
        let(:initial_sell_in) { 11 }
        it '' do
          expect(subject.quality).to eq(initial_quality+1)
        end

        context 'at max quality' do
          let(:initial_quality) { 50 }
        end
      end

      context 'medium close to sell date (upper bound)' do
        let(:initial_sell_in) { 10 }

        it 'should increase quality by 2' do
          expect(subject.quality).to eq(initial_quality+2)
        end

        context 'at max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end

      context 'medium close to sell date (lower bound)' do
        let(:initial_sell_in) { 6 }

        it 'should increase quality by 2' do
          expect(subject.quality).to eq(initial_quality+2)
        end

        context 'at max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end

      context 'very close to sell date (upper bound)' do
        let(:initial_sell_in) { 5 }

        it 'should increase quality by 3' do
          expect(subject.quality).to eq(initial_quality+3)
        end

        context 'at max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end

      context 'very close to sell date (lower bound)' do
        let(:initial_sell_in) { 1 }

        it 'should increase quality by 3' do
          expect(subject.quality).to eq(initial_quality+3)
        end

        context 'at max quality' do
          let(:initial_quality) { 50 }

          it 'should not change quality' do
            expect(subject.quality).to eq(initial_quality)
          end
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'should not set quality to 0' do
          expect(subject.quality).to eq(0)
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }

        it 'should not set quality to 0' do
          expect(subject.quality).to eq(0)
        end
      end
    end

    xcontext 'conjured item' do
      let(:name) { 'Conjured Mana Cake' }

      it 'should decrease sell_in by 1' do
        expect(subject.sell_in).to eq(initial_sell_in-1)
      end

      context 'before the sell date' do
        let(:initial_sell_in) { 5 }

        it 'should decrease quality by 2' do
          expect(item.quality).to eq(initial_quality-2)
        end

        context 'at zero quality' do
          let(:initial_quality) { 0 }

          it 'should not change quality' do
            expect(item.quality).to eq(initial_quality)
          end
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'should decrease quality by 4' do
          expect(item.quality).to eq(initial_quality-4)
        end

        context 'at zero quality' do
          let(:initial_quality) { 0 }

          it 'should not change quality' do
            expect(item.quality).to eq(initial_quality)
          end
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -10 }

        it 'should decrease quality by 4' do
          expect(item.quality).to eq(initial_quality-4)
        end

        context 'at zero quality' do
          let(:initial_quality) { 0 }

          it 'should not change quality' do
            expect(item.quality).to eq(initial_quality)
          end
        end
      end
    end
  end

  context 'with several items' do
    let(:item) { Item.new('NORMAL ITEM',
                          5,
                          10) }
    let(:brie) { Item.new('Aged Brie',
                          3,
                          10) }
    let(:items) { [item, brie] }

    before(:each) do
      update_quality(items)
    end

    context 'normal item' do
      subject { item }

      it 'should have quality 9' do
        expect(subject.quality).to eq(9)
      end

      it 'should have sell_in 4' do
        expect(subject.sell_in).to eq(4)
      end
    end

    context 'brie' do
      subject { brie }

      it 'should have quality 11' do
        expect(brie.quality).to eq(11)
      end

      it 'should have sell_in 2' do
        expect(brie.sell_in).to eq(2)
      end
    end
  end
end
