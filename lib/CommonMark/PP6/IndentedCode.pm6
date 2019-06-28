use v6;

use CommonMark::PP6::Node;
use CommonMark::PP6::Text;

class CommonMark::PP6::IndentedCode does Node is export {
    method render {
        "<pre><code>{@.content.map( { $_.render } ).join("").chomp}\n</code></pre>";
    }

    multi method merge ( CommonMark::PP6::IndentedCode $new ) {
        $new.content = [ |self.content, Text.new( text => "\n"), |$new.content ];
        return ( $new );
    }
}
