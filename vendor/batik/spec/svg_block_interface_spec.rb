require 'spec_helper'

describe 'Batik::SVG with block interface' do
  describe '#rectangle' do
    let(:svg) { Batik::SVG.new }

    it 'add new rect element' do
      svg.rectangle do
        coordinates 10, 20
        dimensions 20, 30
        color :fill => 'red'
      end

      svg.to_s.should match 'rect.*fill="red".*x="10".*y="20"'
      svg.to_s.should match 'rect.*width="20".*height="30"'
    end
  end

  describe '#circle' do
    let(:svg) do
      Batik::SVG.new do
        circle do
          coordinates 10, 10
          radius 20
          color :fill => 'blue'
        end
      end
    end

    it 'add new circle element' do
      svg.to_s.should match '<circle fill="blue" r="20" cx="10" cy="10"/>'
    end
  end

  describe '#text' do
    let(:svg) do
      Batik::SVG.new do
        text do
          coordinates 10, 10
          body 'SVG random text'
        end
      end
    end

    it 'add new text element' do
      svg.to_s.should match '<text x="10" y="10">SVG random text</text>'
    end
  end

  describe '#path' do
    let(:svg) do
      Batik::SVG.new do
        path do
          move 100, 100
          line 300, 100
          line 200, 300
          horizontal_line 300
          vertical_line 100
          curve 10, 10, 20, 20, 30, 30
          smooth_curve 10, 10, 20, 20
          close
          color :fill => 'red', :stroke => 'blue'
        end
      end
    end

    it 'add new path element' do
      svg.to_s.should match 'path fill="red" d=".*" stroke="blue"'
      svg.to_s.should match 'd="M 100 100 L 300 100 L 200 300 H 300 V 100 '
      svg.to_s.should match 'd=.* C 10 10 20 20 30 30 S 10 10 20 20 Z "'
    end
  end

  describe '#ellipse' do
    let(:svg) do
      Batik::SVG.new do
        ellipse do
          coordinates 100, 100
          radius 50, 20
        end
      end
    end

    it 'add new ellipse element' do
      svg.to_s.should match '<ellipse rx="50" ry="20" cx="100" cy="100"/>'
    end
  end

  describe '#image' do
    let(:svg) do
      Batik::SVG.new do
        image do
          coordinates 10, 10
          dimensions 73, 73
          link 'sample.png'
        end
      end
    end

    it 'add new image element' do
      svg.to_s.should match 'image x="10" y="10" width="73"'
    end
  end

  describe '#g' do
    let(:svg) do
      Batik::SVG.new do
        group do 
          color :fill => 'red'

          circle do
            coordinates 10, 10
            radius 5
          end
        end
      end
    end

    it 'add new g element with the nested elements in it' do
      svg.to_s.should match '<g fill="red"><circle r="5" cx="10" cy="10"/></g>'
    end
  end

  describe 'transformation' do
    let(:svg) do
      Batik::SVG.new do
        group do
          translate 30, 30
          scale 2, 5
          rotate 30
        end
      end
    end

    it 'add corresponding transformation attributes' do
      svg.to_s.should match 'g transform="translate.* scale.* rotate.* "'
      svg.to_s.should match '"translate\(30, 30\) scale\(2, 5\) rotate\(30\) "'
    end
  end
end
