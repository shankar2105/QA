# Determine the appropriate arch to install
if ($env:PLATFORM -eq "x86") {
    $arch = "i686"
}
else {
    $arch = "x86_64"
}

$rust_version = $env:RUST_VERSION
$rust_install = "rust-$rust_version-$arch-pc-windows-gnu.msi"

# Download Rust installer
if ($rust_version -eq "nightly") {
    Start-FileDownload "http://static.rust-lang.org/dist/2015-10-19/$rust_install" -FileName $rust_install
} else {
    Start-FileDownload "https://static.rust-lang.org/dist/$rust_install" -FileName $rust_install
}

# Install Rust
Start-Process -FilePath msiexec -ArgumentList /i, $rust_install, /quiet, INSTALLDIR="C:\Rust" -Wait

# Add Rust to path
$env:Path = "C:\Rust\bin;" + $env:Path

"Rust version:"
""
rustc -vV
""
""

"Cargo version:"
""
cargo -V
""
""

# Make sure git submodules are included
git submodule update --init --recursive
